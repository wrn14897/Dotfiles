#!/usr/bin/env bash
# wt-cleanup-merged — remove worktrees whose branches are already merged to the
# default branch on the remote, plus their related OpenCode sessions, plus
# orphan OpenCode state on disk.
#
# Usage:
#   wt-cleanup-merged [--dry-run] [--include-dirty] [--no-fetch]
#
# Behavior is documented in this file's source. Re-runs are idempotent.

set -euo pipefail

# ---------- args ----------
DRY_RUN=0
INCLUDE_DIRTY=0
DO_FETCH=1
for arg in "$@"; do
  case "$arg" in
    --dry-run)        DRY_RUN=1 ;;
    --include-dirty)  INCLUDE_DIRTY=1 ;;
    --no-fetch)       DO_FETCH=0 ;;
    -h|--help)
      sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *)
      echo "wt-cleanup-merged: unknown option: $arg" >&2
      echo "Try --help" >&2
      exit 2 ;;
  esac
done

# ---------- preflight ----------
for cmd in wt opencode jq git python3; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "wt-cleanup-merged: required command '$cmd' not found in PATH" >&2
    exit 3
  fi
done

OPENCODE_DATA_DIR="$(opencode debug paths 2>/dev/null | awk '$1=="data"{print $2}')"
if [[ -z "${OPENCODE_DATA_DIR:-}" ]]; then
  OPENCODE_DATA_DIR="$HOME/.local/share/opencode"
fi
SNAPSHOT_DIR="$OPENCODE_DATA_DIR/snapshot"

log()    { printf '%s\n' "$*"; }
note()   { printf '  %s\n' "$*"; }
header() { printf '\n=== %s ===\n' "$*"; }

realpath_py() {
  # Portable realpath using python3.
  python3 -c 'import os,sys; print(os.path.realpath(sys.argv[1]))' "$1"
}

# Counters used in summary
removed_worktrees=0
deleted_sessions=0
pruned_snapshots=0
freed_bytes=0

# ---------- Phase 1: refresh remote ----------
header "Phase 1: refresh remote"
if [[ $DO_FETCH -eq 1 ]]; then
  # Resolve primary worktree from `wt list` so we don't depend on $PWD.
  primary_path="$(wt list --format json 2>/dev/null \
    | jq -r 'map(select(.is_main == true)) | .[0].path // empty')"
  if [[ -z "$primary_path" ]]; then
    # Fallback: assume current dir's git common dir's worktree
    primary_path="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
  fi
  log "fetching --prune origin from $primary_path"
  ( cd "$primary_path" && git fetch --quiet --prune origin ) || {
    echo "warn: git fetch failed; continuing with stale local state" >&2
  }
else
  log "skipping fetch (--no-fetch)"
fi

# ---------- Phase 2: remove safe-merged worktrees ----------
header "Phase 2: remove merged worktrees"

# main_state values we treat as "safe to remove" — same set wt's own
# branch-cleanup logic uses. See `wt remove --help`.
SAFE_STATES_RE='^(empty|same_commit|ancestor|tree_match|merge_clean|patch_match)$'

# wt list might fail (e.g. detached HEAD primary, panics on certain configs);
# guard so the rest of the script still runs.
worktrees_json="$(wt list --format json 2>/dev/null || echo '[]')"

candidates_json="$(echo "$worktrees_json" | jq -c \
  --argjson include_dirty "$INCLUDE_DIRTY" '
    def safe_states: ["empty","same_commit","ancestor","tree_match","merge_clean","patch_match"];
    map(select(
      ((.is_main // false) == false)
      and ((.is_current // false) == false)
      and ((.worktree.detached // false) == false)
      and (((.main_state // "") | tostring) as $s | safe_states | index($s) != null)
    ))
    | map(select(
        $include_dirty == 1
        or (
          ((.working_tree.modified  // false) == false)
          and ((.working_tree.staged    // false) == false)
          and ((.working_tree.untracked // false) == false)
          and ((.working_tree.renamed   // false) == false)
          and ((.working_tree.deleted   // false) == false)
        )
      ))
  ')"

candidate_count="$(echo "$candidates_json" | jq 'length')"
log "found $candidate_count merged worktree(s) eligible for removal"

if [[ "$candidate_count" -gt 0 ]]; then
  while IFS=$'\t' read -r branch path state; do
    [[ -z "$branch" ]] && continue
    log ""
    log "candidate: branch=$branch state=$state path=$path"
    if [[ $DRY_RUN -eq 1 ]]; then
      note "[dry-run] would: wt remove --foreground --yes $branch"
    else
      if wt remove --foreground --yes "$branch"; then
        note "removed"
        removed_worktrees=$((removed_worktrees + 1))
      else
        note "wt remove failed for $branch (continuing)"
      fi
    fi
  done < <(echo "$candidates_json" | jq -r '.[] | "\(.branch)\t\(.path)\t\(.main_state // "")"')
fi

# ---------- Phase 3: orphan OpenCode session sweep ----------
header "Phase 3: orphan OpenCode session sweep"

sessions_json="$(opencode session list --format json 2>/dev/null || echo '[]')"
session_total="$(echo "$sessions_json" | jq 'length')"
log "scanning $session_total session(s)"

# A session is orphan if its (realpath'd) directory does not exist on disk.
# We don't trust string-prefix matching against the worktree list because
# sessions may live in subdirectories of worktrees, and worktrees that just
# got removed in Phase 2 are gone anyway.
while IFS=$'\t' read -r sid sdir; do
  [[ -z "$sid" ]] && continue
  # Empty / null directory — leave alone, manual review.
  if [[ -z "$sdir" || "$sdir" == "null" ]]; then
    continue
  fi
  resolved=""
  # If the path exists, realpath_py succeeds; otherwise it returns the
  # "would-be" resolution, which is fine because we re-test with -e below.
  resolved="$(realpath_py "$sdir" 2>/dev/null || echo "$sdir")"
  if [[ -e "$resolved" ]]; then
    continue
  fi
  log "orphan session: $sid  ($sdir)"
  if [[ $DRY_RUN -eq 1 ]]; then
    note "[dry-run] would: opencode session delete $sid"
  else
    if opencode session delete "$sid"; then
      deleted_sessions=$((deleted_sessions + 1))
    else
      note "opencode session delete failed for $sid (continuing)"
    fi
  fi
done < <(echo "$sessions_json" | jq -r '.[] | "\(.id)\t\(.directory // "")"')

# ---------- Phase 4: orphan snapshot prune ----------
header "Phase 4: orphan snapshot prune"

if [[ ! -d "$SNAPSHOT_DIR" ]]; then
  log "no snapshot dir at $SNAPSHOT_DIR — skipping"
else
  scrap_json="$(opencode debug scrap 2>/dev/null || echo '[]')"
  for snap in "$SNAPSHOT_DIR"/*/; do
    [[ -d "$snap" ]] || continue
    pid="$(basename "$snap")"

    # Look up this project in `scrap`. If it's not tracked at all, conservatively skip
    # (don't delete things opencode hasn't acknowledged).
    proj_entry="$(echo "$scrap_json" | jq -c --arg pid "$pid" '.[] | select(.id == $pid)' 2>/dev/null || true)"
    if [[ -z "$proj_entry" ]]; then
      continue
    fi

    proj_worktree="$(echo "$proj_entry" | jq -r '.worktree // ""')"
    sandbox_paths="$(echo "$proj_entry" | jq -r '.sandboxes // [] | .[]')"

    # Any live path tied to this project? Worktree or any sandbox.
    live=0
    if [[ -n "$proj_worktree" && -e "$proj_worktree" ]]; then
      live=1
    fi
    if [[ $live -eq 0 && -n "$sandbox_paths" ]]; then
      while IFS= read -r sb; do
        [[ -z "$sb" ]] && continue
        if [[ -e "$sb" ]]; then live=1; break; fi
      done <<< "$sandbox_paths"
    fi

    if [[ $live -eq 1 ]]; then
      continue
    fi

    # Fully orphan: tracked project, no worktree on disk, no live sandboxes.
    bytes="$(du -sk "$snap" 2>/dev/null | awk '{print $1*1024}')"
    log "orphan snapshot: $pid  (worktree=$proj_worktree)  size=${bytes:-0} bytes"
    if [[ $DRY_RUN -eq 1 ]]; then
      note "[dry-run] would: rm -rf $snap"
    else
      rm -rf "$snap"
      pruned_snapshots=$((pruned_snapshots + 1))
      freed_bytes=$((freed_bytes + ${bytes:-0}))
    fi
  done
fi

# ---------- Phase 5: VACUUM if anything was deleted ----------
header "Phase 5: VACUUM"

if [[ $DRY_RUN -eq 0 && $deleted_sessions -gt 0 ]]; then
  log "running: opencode db \"VACUUM;\""
  opencode db "VACUUM;" >/dev/null 2>&1 || {
    echo "warn: VACUUM failed (non-fatal)" >&2
  }
else
  log "skipping VACUUM (nothing deleted, or --dry-run)"
fi

# ---------- summary ----------
header "Summary"
mode="apply"; [[ $DRY_RUN -eq 1 ]] && mode="dry-run"
log "mode:               $mode"
log "worktrees removed:  $removed_worktrees"
log "sessions deleted:   $deleted_sessions"
log "snapshots pruned:   $pruned_snapshots"
log "snapshot bytes:     $freed_bytes"
exit 0

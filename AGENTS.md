# AGENTS.md

Personal dotfiles repo. No build, test, or lint tooling — verification is reading the config and, where cheap, syntax-checking (`zsh -n`, `tmux -f .tmux.conf` etc.).

## Copy workflow (not symlinks)

Configs are **copied** between this repo and `$HOME` / `~/.config`, per README instructions. Live files in `$HOME` drift from the repo (e.g. `~/.zshrc` has local additions not committed here). When asked to "update a dotfile", clarify direction: edit the repo copy, and only copy to `$HOME` if asked.

## Canonical paths — duplicates exist

Two configs have stale duplicates in the repo. Edit the canonical one:

- zsh: canonical is `zsh/.zshrc` (README references it; newer). Root `.zshrc` is an older copy.
- herdr: canonical is `herdr/` at repo root (README references it; newer). `.config/herdr/config.toml` is an older copy.

## Layout facts

- `.config/opencode/` is a tracked snapshot of the global `~/.config/opencode/` (agent config, plugins, global AGENTS.md). Its own `.gitignore` excludes `node_modules`, `package*.json`, `logs/` — don't commit those.
- `.config/nvim/lazy-lock.json` is the lazy.nvim lockfile and is intentionally tracked. `packer_compiled.lua` and `.luarc.json` are gitignored legacy artifacts.
- `.local/bin/opencode-continue` resumes the most recent opencode session for the cwd (requires `jq`).
- Homebrew packages: `brew bundle --file=./homebrew/Brewfile`.
- After changing herdr config on a running server: `herdr server reload-config`.

## Secrets

API keys/tokens go in `~/.zshrc.secrets` (sourced at the end of `.zshrc`, never committed). Never add credentials to any tracked file.

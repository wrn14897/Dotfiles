# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Lazy-load nvm: defers sourcing nvm.sh until nvm/node/npm/etc. is first used
zstyle ':omz:plugins:nvm' lazy yes
plugins=(
  docker
  git
  nvm
  python
  zsh-autosuggestions
  zsh-syntax-highlighting
  poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.docker_aliases ]; then
    . ~/.docker_aliases
fi

# NVM is loaded lazily via the oh-my-zsh nvm plugin (see plugins array above)

# Go
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH=$HOME/Codes/Go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Python
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# UTF-8 supports
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --color=always'
[[ -s "$HOME/Codes/fzf-git.sh/fzf-git.sh" ]] && source "$HOME/Codes/fzf-git.sh/fzf-git.sh"
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# private bin
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# bat
export BAT_THEME="Catppuccin-frappe" #TEMP: ideally we use KANAGAWA

# rvm
# export GEM_HOME=$HOME/.gem
# export GEM_PATH=$HOME/.gem

# # github
compctl -K _gh gh
# eval "$(gh copilot alias -- zsh)" VERY SLOW...

# openai

# anthropic
export ANTHROPIC_ENABLE_1M_CONTEXT=true
export ANTHROPIC_CLI_VERSION=2.1.81

# kubectl (completion cached to a file; regenerated when kubectl binary is newer)
if command -v kubectl >/dev/null 2>&1; then
  _kubectl_comp=~/.cache/kubectl-completion.zsh
  if [[ ! -f $_kubectl_comp || $_kubectl_comp -ot ${commands[kubectl]} ]]; then
    mkdir -p ~/.cache && kubectl completion zsh > $_kubectl_comp
  fi
  source $_kubectl_comp
  compdef __start_kubectl k
  unset _kubectl_comp
fi
# source <(minikube completion zsh)

# Homebrew
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# K8s
export KUBE_EDITOR="nvim"

# RN
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# chromium
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
(( $+commands[chromium] )) && export PUPPETEER_EXECUTABLE_PATH="$commands[chromium]"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# zoxide
if [[ $- == *i* ]]; then
    eval "$(zoxide init zsh --cmd cd)"
else
    # For non-interactive shells, use standard cd
    unalias cd 2>/dev/null
fi

# herdr
for _f in ${HOME}/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.zsh(N); do
  source $_f; break
done

# custom functions
wt-linear() {
    local branch="$1"
    tmux new-window -n "$branch" "wt switch -c '$branch' -x \"opencode --prompt '/do-linear $branch'\""
}
wt-plan-linear() {
    local branch="$1"
    tmux new-window -n "$branch" "wt switch -c '$branch' -x \"opencode --prompt '/plan-linear $branch'\""
}
wt-continue() {
    local branch="$1"
    tmux new-window -n "$branch" "wt switch '$branch' -x 'opencode-continue'"
}
wt-open() {
    local branch="$1"
    tmux new-window -n "$branch" "wt switch -c '$branch' -x 'opencode'"
}
# Remove worktrees whose branch was merged (remote branch gone after prune),
# and delete any opencode sessions tied to those worktree directories.
wt-clean-merged() {
    local opencode_db="$HOME/.local/share/opencode/opencode.db"

    git rev-parse --git-dir >/dev/null 2>&1 || { echo "wt-clean-merged: not inside a git repo" >&2; return 1; }

    echo "Fetching and pruning remotes..."
    git fetch --prune --quiet || { echo "wt-clean-merged: git fetch failed" >&2; return 1; }

    # Branches whose upstream is gone (covers squash-merged PRs).
    local -a gone_branches
    gone_branches=("${(@f)$(git for-each-ref --format '%(refname:short)	%(upstream:track)' refs/heads \
        | awk -F'\t' '$2=="[gone]"{print $1}')}")
    gone_branches=("${(@)gone_branches:#}")

    if (( ${#gone_branches} == 0 )); then
        echo "No merged worktrees to clean."
        return 0
    fi

    # Map worktree branches -> paths, skipping main worktree, detached HEADs,
    # and the worktree we're currently standing in.
    local main_wt cur_wt
    main_wt=$(git worktree list --porcelain | awk '/^worktree /{print substr($0,10); exit}')
    cur_wt=$(git rev-parse --show-toplevel)

    local -a candidates candidate_paths
    local wt_path="" wt_branch="" line
    while IFS= read -r line || [[ -n "$line" ]]; do
        case "$line" in
            worktree\ *) wt_path="${line#worktree }" ;;
            branch\ *)   wt_branch="${line#branch refs/heads/}" ;;
            "")
                if [[ -n "$wt_branch" && "$wt_path" != "$main_wt" && "$wt_path" != "$cur_wt" ]] \
                    && (( ${gone_branches[(Ie)$wt_branch]} )); then
                    candidates+=("$wt_branch")
                    candidate_paths+=("$wt_path")
                fi
                wt_path="" wt_branch=""
                ;;
        esac
    done < <(git worktree list --porcelain; echo)

    if (( ${#candidates} == 0 )); then
        echo "No merged worktrees to clean."
        return 0
    fi

    echo
    echo "Merged worktrees to remove (wt remove -D):"
    local i sessions n_sessions
    for (( i = 1; i <= ${#candidates}; i++ )); do
        n_sessions=0
        if [[ -f "$opencode_db" ]] && command -v sqlite3 >/dev/null 2>&1; then
            n_sessions=$(sqlite3 "$opencode_db" \
                "SELECT COUNT(*) FROM session WHERE directory = '${candidate_paths[i]}' OR directory LIKE '${candidate_paths[i]}/%';" 2>/dev/null)
        fi
        printf '  %-50s %s  (%s opencode sessions)\n' "${candidates[i]}" "${candidate_paths[i]}" "${n_sessions:-0}"
    done
    echo

    local reply
    read -q "reply?Remove ${#candidates} worktree(s) and their opencode sessions? [y/N] " || { echo; echo "Aborted."; return 1; }
    echo

    for (( i = 1; i <= ${#candidates}; i++ )); do
        # Delete opencode sessions tied to this worktree dir (before removing it).
        if [[ -f "$opencode_db" ]] && command -v sqlite3 >/dev/null 2>&1; then
            sessions=("${(@f)$(sqlite3 "$opencode_db" \
                "SELECT id FROM session WHERE directory = '${candidate_paths[i]}' OR directory LIKE '${candidate_paths[i]}/%';" 2>/dev/null)}")
            sessions=("${(@)sessions:#}")
            local sid
            for sid in "${sessions[@]}"; do
                echo "Deleting opencode session $sid"
                opencode session delete "$sid" || echo "  failed to delete session $sid" >&2
            done
        fi
        echo "Removing worktree ${candidates[i]} (${candidate_paths[i]})"
        wt remove -D --foreground "${candidates[i]}" || echo "  failed to remove ${candidates[i]}" >&2
    done

    echo "Done."
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

complete -o nospace -C /opt/homebrew/bin/terraform terraform

# pnpm
export PNPM_HOME="/Users/warren/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# Secrets (API keys, tokens) live outside dotfiles repo
[ -f ~/.zshrc.secrets ] && source ~/.zshrc.secrets

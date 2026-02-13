[[ $- != *i* ]] && return # Only load in interactive mode

# ---------------------
# Environment Detection
# ---------------------

# Detect Windows/WSL
if grep -qi microsoft /proc/version 2>/dev/null || grep -qi wsl /proc/version 2>/dev/null; then
  export IS_WSL=true
else
  export IS_WSL=false
fi

# Detect Wayland vs. X11
if [[ -n "${XDG_SESSION_TYPE-}" ]] && [[ "${XDG_SESSION_TYPE-}" = "wayland" ]]; then
  export IS_WAYLAND=true
else
  export IS_WAYLAND=false
fi

# Set appropriate clipboard command
if [[ "${IS_WSL}" = true ]]; then
  # WSL
  export CLIP_CMD="clip.exe"
elif command -v wl-copy >/dev/null 2>&1 && [[ "${IS_WAYLAND}" = true ]]; then
  # Wayland
  export CLIP_CMD="wl-copy"
elif command -v xclip >/dev/null 2>&1; then
  # X11 (needs flags to use system clipboard/stdin)
  export CLIP_CMD="xclip -selection clipboard -in"
elif command -v pbcopy >/dev/null 2>&1; then
  # MacOS
  export CLIP_CMD="pbcopy"
elif [[ -n "${TMUX}" ]]; then
  # tmux
  export CLIP_CMD="tmux load-buffer -"
else
  export CLIP_CMD=":"
fi

# Ensure local bin available
if [[ ":${PATH}:" != *":${HOME}/.local/bin:"* ]]; then
  export PATH="${HOME}/.local/bin:${PATH}"
fi

export PATH="${HOME}/Code/scripts:${PATH}"

# Source rust/cargo env to add bob/cargo to PATH
if [[ -f "${HOME}/.cargo/env" ]]; then
  source "${HOME}/.cargo/env"
fi

# Set homebrew env if it's installed
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [[ -d "/home/linuxbrew/.linuxbrew" || -d "${HOME}/.linuxbrew" ]]; then
  for brew_dir in "/home/linuxbrew/.linuxbrew" "${HOME}/.linuxbrew"; do
    if [[ -x "${brew_dir}/bin/brew" ]]; then
      eval "$("${brew_dir}/bin/brew" shellenv)"
      break
    fi
  done
fi

# ---------------------
# zinit Plugin Manager
# ---------------------

# Install zinit if not present in local path, then source it
ZINIT_DIR="${HOME}/.local/share/zinit/zinit.git"
if [[ ! -f "${ZINIT_DIR}/zinit.zsh" ]]; then
  mkdir -p "$(dirname "${ZINIT_DIR}")"
  if ! git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_DIR}" 2>/dev/null; then
    echo "Warning: Failed to install zinit plugin manager" >&2
  fi
fi
if [[ -f "${ZINIT_DIR}/zinit.zsh" ]]; then
  source "${ZINIT_DIR}/zinit.zsh"
fi

# vi-mode options (plugin version)
# ZVM_SYSTEM_CLIPBOARD_ENABLED=true
# ZVM_VI_ESCAPE_BINDKEY=kj
# ZVM_VI_HIGHLIGHT_BACKGROUND=none

# zinit plugins
# typeset -f checks if shell function exists
if typeset -f zinit >/dev/null 2>&1; then
  # ice depth of 1 saves performance by making shallow clones
  zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
  zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
  zinit ice depth=1; zinit light zsh-users/zsh-completions
  zinit ice depth=1; zinit light zdharma-continuum/fast-syntax-highlighting
  # vi-mode plugin (currently using built-in)
  # zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
fi

# ---------------------
# Shell Options
# ---------------------

# cd without typing cd
setopt autocd
# Spelling correction
setopt correct
setopt share_history
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt autopushd
setopt pushdignoredups
setopt pushdsilent

# ---------------------
# Completion
# ---------------------

# Mark compinit to delay load until called
autoload -Uz compinit
local comp_dump="${ZDOTDIR:-$HOME}/.zcompdump"
# Check if compinit cache is less than 24 hours old
if [[ -n "${comp_dump}(#qN.mh+24)" ]]; then
  compinit
else
  # If not, use existing cache
  compinit -C
fi

# Single quotes used because variable expansion not needed
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ---------------------
# fzf
# ---------------------

if [[ -f "${HOME}/.fzf.zsh" ]]; then
  source "${HOME}/.fzf.zsh"
else
  # Check common package-managed install locations if not in $HOME
  for p in /usr/share/doc/fzf/examples/fzf.zsh /usr/local/opt/fzf/shell/key-bindings.zsh; do
    if [[ -f "${p}" ]]; then
      source "${p}" && break
    fi
  done
fi

# Also check for completions
for p in "${HOME}/.fzf.zsh" /usr/share/doc/fzf/examples/completion.zsh /usr/local/opt/fzf/shell/completion.zsh; do
  if [[ -f "${p}" ]]; then
    source "${p}" && break
  fi
done

# ---------------------
# zoxide
# ---------------------

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ---------------------
# Starship Prompt
# ---------------------

# Alternative, minimal starship config if inside a TMUX session
# if [[ -n "${TMUX-}" ]] && [[ -f "${HOME}/.config/starship-tmux.toml" ]]; then
#   export STARSHIP_CONFIG="${HOME}/.config/starship-tmux.toml"
# fi

# Execute Starship setup if it exists
if command -v starship >/dev/null 2>&1; then
  type starship_zle-keymap-select >/dev/null || \
    {
      eval "$(starship init zsh)"
    }
fi

# ---------------------
# Yazi
# ---------------------

# Shell wrapper - use yazi with y
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ---------------------
# Default Editor
# ---------------------

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ---------------------
# vi-mode
# ---------------------

bindkey -v
bindkey -M viins 'kj' vi-cmd-mode
# Allow backspace/delete to work correctly with history
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# ---------------------
# Aliases
# ---------------------

# Aliases kept separate to allow for use by multiple shells
[[ -f ~/.aliases ]] && source ~/.aliases

# ---------------------
# Repo-specific env
# ---------------------

# Only source if present
[[ -f "${HOME}/.profile" ]] && source "${HOME}/.profile"

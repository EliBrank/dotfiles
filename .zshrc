# Only load in interactive mode
[[ $- != *i* ]] && return

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
if [ -n "${XDG_SESSION_TYPE-}" ] && [ "${XDG_SESSION_TYPE-}" = "wayland" ]; then
  export IS_WAYLAND=true
else
  export IS_WAYLAND=false
fi

# Set appropriate clipboard command
if [ "$IS_WSL" = true ]; then
  # WSL
  export CLIP_CMD="clip.exe"
elif command -v wl-copy >/dev/null 2>&1 && [ "$IS_WAYLAND" = true ]; then
  # Wayland
  export CLIP_CMD="wl-copy"
elif command -v xclip >/dev/null 2>&1; then
  # X11 (needs flags to use system clipboard/stdin)
  export CLIP_CMD="xclip -selection clipboard -in"
elif command -v pbcopy >/dev/null 2>&1; then
  # MacOS
  export CLIP_CMD="pbcopy"
elif [ -n "$TMUX" ]; then
  # tmux
  export CLIP_CMD="tmux load-buffer -"
else
  export CLIP_CMD=":"
fi

# Ensure local bin available
export PATH="$HOME/.local/bin:$PATH"

# Source rust/cargo env to add bob/cargo to PATH
if [ -f "$HOME/.cargo/env" ]; then
  # Below comment suppresses linter warning about dynamic sourcing
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi

# Set homebrew env if it's installed
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [ -d "/home/linuxbrew/.linuxbrew" ] || [ -d "$HOME/.linuxbrew" ]; then
  for brew_dir in "home/linuxbrew/.linuxbrew" "$HOME/.linuxbrew"; do
    if [ -x "$brew_dir/bin/brew" ]; then
      eval "$("$brew_dir/bin/brew" shellenv)"
      break
    fi
  done
fi

# ---------------------
# zinit Plugin Manager
# ---------------------

# Install zinit if not present in local path, then source it
ZINIT_DIR="${HOME}/.local/share/zinit/zinit.git"
if [ ! -f "${ZINIT_DIR}/zinit.zsh" ]; then
  mkdir -p "$(dirname "$ZINIT_DIR")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_DIR" 2>/dev/null || true
fi
if [ -f "${ZINIT_DIR}/zinit.zsh" ]; then
  # Below comment suppresses linter warning about dynamic sourcing
  # shellcheck disable=SC1090
  source "${ZINIT_DIR}/zinit.zsh"
fi

# zinit plugins
# typeset -f checks if shell function exists
if typeset -f zinit >/dev/null 2>&1; then
  zinit light zsh-users/zsh-autosuggestions
  zinit light zsh-users/zsh-syntax-highlighting
  zinit light zsh-users/zsh-completions
  zinit light jeffreytse/zsh-vi-mode
  # May switch to fast-syntax-highlighting
  # zinit light zdharma-continuum/fast-syntax-highlighting
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
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# ---------------------
# vi-mode
# ---------------------

bindkey -v
export KEYTIMEOUT=10
# TODO compare with old zshrc vi-mode

# ---------------------
# Completion
# ---------------------

autoload -Uz compinit && compinit || true

# ---------------------
# fzf
# ---------------------

if [ -f "$HOME/.fzf.zsh" ]; then
  # Below comment suppresses linter warning about dynamic sourcing
  # shellcheck disable=SC1090
  source "$HOME/.fzf.zsh"
else
  # Check common package-managed install locations if not in $HOME
  for p in /usr/share/doc/fzf/examples/fzf.zsh /usr/local/opt/fzf/shell/key-bindings.zsh; do
    if [ -f "$p" ]; then
      # Below comment suppresses linter warning about dynamic sourcing
      # shellcheck disable=SC1090
      source "$p" && break
    fi
  done
fi

# ---------------------
# Starship Prompt
# ---------------------

if [ -n "${TMUX-}" ] && [ -f "${HOME}/.config/starship-tmux.toml" ]; then
  export STARSHIP_CONFIG="${HOME}/.config/starship-tmux.toml"
fi

# Execute Starship setup if it exists
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ---------------------
# Repo-specific env
# ---------------------

# Only source if present
[ -f "${HOME}/.profile" ] && source "${HOME}/.profile"

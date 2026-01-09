# Oh My Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Theme (empty because using Starship)
ZSH_THEME=""

# Oh My Zsh plugins
plugins=(git)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load Homebrew-installed zsh plugins (cross-platform)
if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)
    if [ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
        source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    fi
    if [ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
        source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
fi

# ===== Custom Configuration =====

# Starship prompt
eval "$(starship init zsh)"

# Vim mode in ZSH
bindkey -v
export KEYTIMEOUT=1

# Keep useful emacs bindings in insert mode
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Better history search with vim keys in normal mode
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

# Eza aliases (modern ls replacement)
alias ls='eza --icons'
alias ll='eza -la --icons'
alias lt='eza --tree --icons'

# Source local environment variables (if exists)
if [ -f "$HOME/.local/bin/env" ]; then
    . "$HOME/.local/bin/env"
fi

# Add local bin to path
export PATH="$HOME/.local/bin:$PATH"

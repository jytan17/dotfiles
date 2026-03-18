# Locale configuration for UTF-8 support
export LANG=C.UTF-8
export LC_ALL=C.UTF-8
# Tell lazygit where to find the config file
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
# Homebrew - works on both macOS and Linux
if [ -f /opt/homebrew/bin/brew ]; then
    # macOS Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    # macOS Intel
    eval "$(/usr/local/bin/brew shellenv)"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
    # Linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Starship prompt config location
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Zinit self-bootstrap
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins loaded via zinit (Powerlevel10k removed in favor of Starship)

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Initialize Starship prompt
eval "$(starship init zsh)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^y' autosuggest-accept

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'

# Aliases
alias ls='eza --icons=always --color=always'
alias ll='eza -l --icons=always --color=always'
alias la='eza -la --icons=always --color=always'
alias lt='eza --tree --icons=always --color=always'
alias vim='nvim'
alias c='clear'
alias lg='lazygit'
alias nf='nvim $(fzf --preview "bat --color=always --style=numbers {}" 2>/dev/null || cat {})'
alias nv='nvim'
# Shell integrations
export FZF_DEFAULT_OPTS="--bind 'ctrl-y:accept'"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"


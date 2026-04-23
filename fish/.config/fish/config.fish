# Locale
set -gx COLORTERM truecolor
set -gx LANG C.UTF-8
set -gx LC_ALL C.UTF-8

# Default editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Lazygit config
set -gx LG_CONFIG_FILE "$HOME/.config/lazygit/config.yml"

# Homebrew
if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
else if test -f /usr/local/bin/brew
    eval (/usr/local/bin/brew shellenv)
else if test -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# Starship prompt
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
starship init fish | source

# Abbreviations (expand when you type them)
abbr g git
abbr ga 'git add'
abbr gaa 'git add --all'
abbr gb 'git branch'
abbr gcm 'git commit -m'
abbr gco 'git checkout'
abbr gd 'git diff'
abbr glog 'git log --oneline --decorate --color --graph'
abbr gloga 'git log --oneline --decorate --graph --all'
abbr gpl 'git pull'
abbr gps 'git push'
abbr grs 'git restore'
abbr gs 'git status'
abbr gsw 'git switch'
abbr gswc 'git switch -c'
abbr c clear
abbr lg lazygit
abbr ld lazydocker
abbr zj zellij
abbr vi nvim
abbr vim nvim
abbr nv nvim
abbr oc opencode

# Aliases (for commands with flags)
alias ls='eza --icons=always --color=always'
alias ll='eza -l --icons=always --color=always'
alias la='eza -la --icons=always --color=always'
alias lt='eza --tree --icons=always --color=always'

# fzf
set -gx FZF_DEFAULT_OPTS "--bind 'ctrl-y:accept'"
fzf --fish | source

# Zoxide
zoxide init fish | source

# Keybindings
bind \cp history-search-backward
bind \cn history-search-forward
bind \cy accept-autosuggestion

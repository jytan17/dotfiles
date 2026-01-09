# Dotfiles

My personal development environment configuration.

## What's Included

- **Zsh** - Shell configuration with Oh My Zsh, Starship prompt, and vim mode
- **Tmux** - Terminal multiplexer with vim-style navigation
- **Neovim** - Editor configuration with AstroNvim

## Quick Setup

On a fresh machine, run:
```bash
# Install git
apt update && apt install -y git

# Clone dotfiles
git clone https://github.com/jytan17/dotfiles.git ~/.dotfiles

# Run install script
cd ~/.dotfiles
./install.sh

# Restart your shell
zsh
```

## What the Install Script Does

1. Installs packages: `zsh`, `tmux`, `neovim`, `stow`
2. Installs Oh My Zsh and plugins
3. Installs Starship prompt
4. Installs eza (modern ls replacement)
5. Installs Tmux Plugin Manager
6. Symlinks all config files to their proper locations

## Post-Install

After installation, start tmux and install plugins:
```bash
tmux
# Press Ctrl+a then I (capital i) to install tmux plugins
```

## Customization

Edit configs in `~/.dotfiles`, commit changes, and they'll be available on all your machines.

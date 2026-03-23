# Dotfiles

Personal configuration files managed with GNU Stow.

## Tools Configured

### Shell & Prompt
- **Fish Shell** - Modern shell with auto-suggestions
- **Starship** - Fast, customizable shell prompt (Catppuccin Mocha theme)

### Terminal
- **Ghostty** - GPU-accelerated terminal emulator

### Text Editor
- **Helix (hx)** - Modal text editor (Catppuccin Mocha theme)
  - Relative line numbers
  - LSP support enabled
  - Custom statusline configuration

### File Management
- **Yazi** - Terminal file manager
  - Custom column ratios: [2, 3, 5] (Fibonacci proportions)
  - Smart-enter plugin (press `l` to open files or enter directories)
  - Catppuccin Mocha theme

### Git
- **Lazygit** - Terminal UI for git
  - Configured to use Helix as editor
  - Delta pager integration
  - Auto-fetch enabled

### macOS Tools
- **AeroSpace** - Tiling window manager
  - Vim-like keybindings (hjkl navigation)
  - 9 workspaces
  - JankyBorders integration for window highlights
- **Karabiner-Elements** - Keyboard customizer

## Prerequisites

### Required

Install Homebrew first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Core Tools

```bash
# Shell & prompt
brew install fish starship

# Terminal
brew install --cask ghostty

# Editor & file management
brew install helix yazi

# Git tools
brew install lazygit git-delta

# Navigation & search
brew install fzf zoxide eza

# Dotfile management
brew install stow
```

### macOS-specific (optional)

```bash
# Window manager & borders
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install borders

# Keyboard customizer
brew install --cask karabiner-elements
```

### Fonts

Install a Nerd Font for proper icon display:
```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

### Yazi Plugins

After installing yazi:
```bash
ya pkg add yazi-rs/plugins:smart-enter
```

## Installation

1. Clone this repository:
```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

2. Use GNU Stow to symlink configurations:
```bash
# Install all configurations
stow */

# Or install individually
stow fish
stow helix
stow yazi
stow lazygit
stow starship
stow ghostty
stow aerospace  # macOS only
stow karabiner  # macOS only
```

3. Change your default shell to Fish:
```bash
# Add fish to allowed shells
echo $(which fish) | sudo tee -a /etc/shells

# Set as default shell
chsh -s $(which fish)
```

4. Restart your terminal

## Fish Shell Features

### Abbreviations
- `g` → git
- `ga` → git add
- `gaa` → git add --all
- `gb` → git branch
- `gcm` → git commit -m
- `gco` → git checkout
- `gd` → git diff
- `gs` → git status
- `lg` → lazygit
- `c` → clear

### Aliases
- `ls` → eza with icons
- `ll` → eza -l with icons
- `la` → eza -la with icons
- `lt` → eza --tree with icons

### Functions
- `y` - Launch yazi with shell directory tracking
- `mkcd <dir>` - Create directory and cd into it

### Keybindings
- `Ctrl+P` - Search backward in history
- `Ctrl+N` - Search forward in history
- `Ctrl+Y` - Accept autosuggestion

## Yazi Configuration

- Column ratio: `[2, 3, 5]` - Parent:Current:Preview in Fibonacci proportions
- Hidden files shown by default
- Directories sorted first
- Press `l` to open files or enter directories (smart-enter plugin)

## Helix Configuration

- Theme: Catppuccin Mocha
- Relative line numbers
- LSP auto-signature help enabled
- Custom cursor shapes (bar for insert, block for normal)

## Lazygit Configuration

- Editor: Helix
- Pager: Delta with dark theme
- Main branches: main, master
- Auto-fetch enabled
- File tree shown in UI

## AeroSpace Keybindings (macOS)

### Window Navigation
- `Alt+H/J/K/L` - Focus left/down/up/right
- `Alt+Shift+H/J/K/L` - Move window left/down/up/right

### Workspaces
- `Alt+1-9` - Switch to workspace
- `Alt+Shift+1-9` - Move window to workspace

### Layouts
- `Alt+Z` - Toggle fullscreen
- `Alt+V` - Join window right (vertical split)
- `Alt+S` - Join window down (horizontal split)
- `Alt+Shift+F` - Toggle float

## Theme

All tools are configured with **Catppuccin Mocha** theme for a consistent look.

## Troubleshooting

### Fish functions not working
Make sure the functions are symlinked:
```bash
ls -la ~/.config/fish/functions/
```

### Yazi column ratios not applying
Ensure the config section is `[mgr]` not `[manager]` and restart yazi.

### AeroSpace not starting
Grant accessibility permissions in System Settings > Privacy & Security > Accessibility

### Fonts not displaying correctly
Install JetBrains Mono Nerd Font or another Nerd Font variant.

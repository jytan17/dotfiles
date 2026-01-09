# Dotfiles

My personal development environment configuration, optimized for Python development with modern CLI tools.

## Features

### Shell Configuration
- **Bash** & **Zsh** - Both configured with Homebrew auto-initialization, UTF-8 locale, and 256-color support
- **Starship** - Gruvbox Rainbow theme with icons and git integration
- **Oh My Zsh** - With autosuggestions and syntax highlighting plugins
- **Vim Mode** - Enabled in zsh with useful emacs bindings preserved

### Terminal
- **Tmux** - Terminal multiplexer with:
  - True color (24-bit) support
  - Vim-style pane navigation (hjkl)
  - Custom prefix: `Ctrl+a` (instead of `Ctrl+b`)
  - Tmux Plugin Manager (TPM) pre-installed
  - Integrated vim-tmux navigation

### Editor
- **Neovim** - AstroNvim configuration with:
  - Mason package manager (auto-installs LSP servers)
  - Python support: basedpyright (LSP) + ruff (linter/formatter)
  - Lua support: lua-language-server + stylua
  - Treesitter for syntax highlighting
  - Format-on-save enabled for Python

### Development Tools
- **Python**: `uv` (fast package manager), `basedpyright`, `ruff`
- **Search**: `ripgrep` (rg) for fast grep, `fd` for file finding
- **Git**: `lazygit` TUI integrated with nvim
- **Modern CLI**: `eza` (modern ls with icons)

### Package Management
- **Homebrew** - Cross-platform package manager (Linux & macOS)
- **Stow** - GNU Stow for symlink management

## Quick Setup

### Prerequisites
```bash
# Ubuntu/Debian
apt update && apt install -y build-essential curl git

# macOS - Install Xcode Command Line Tools (Homebrew installer will prompt)
```

### Installation
```bash
# Clone dotfiles
git clone https://github.com/jytan17/dotfiles.git ~/.dotfiles

# Run install script (supports Linux and macOS)
cd ~/.dotfiles
./install.sh

# Restart your shell or run
exec zsh
```

## What the Install Script Does

1. **System Dependencies** - Installs build tools (Linux only)
2. **Homebrew** - Installs and configures for current session
3. **Development Tools** - Installs gcc, zsh, starship, eza, stow
4. **Python Development** - Installs uv package manager
5. **Shell Configuration** - Installs Oh My Zsh with plugins, configures Starship
6. **Dotfile Deployment** - Stows bash, zsh, and tmux configurations
7. **Tmux Setup** - Installs Tmux Plugin Manager and plugins automatically
8. **Neovim Setup** - Installs neovim and essential tools (ripgrep, fd, lazygit, node)

All configurations are automatically symlinked to your home directory using GNU Stow.

## Post-Install

### First Launch
When you first open nvim, Mason will automatically install:
- `lua-language-server` and `stylua` (Lua)
- `basedpyright` and `ruff` (Python)
- `debugpy` (Python debugger)
- `tree-sitter-cli` (syntax parsing)

This happens once and may take a minute.

### Tmux Plugins
Tmux plugins are auto-installed by the script. If you add new plugins later:
```bash
# Press Ctrl+a then I (capital i) to install new plugins
```

## Key Features Explained

### Terminal Colors
- UTF-8 locale configured for icon support
- 256-color terminal mode
- True color (24-bit) support in tmux
- Works correctly when using tmux inside terminals

### Homebrew Integration
- Automatically initialized in both bash and zsh
- Cross-platform support (macOS Apple Silicon, Intel, Linux)
- No manual `eval` commands needed

### Python Development
- **basedpyright**: Type checking with standard mode
- **ruff**: Fast linting and formatting (88 char line length)
- **uv**: Faster alternative to pip with better dependency resolution
- Format-on-save enabled for Python files

### Vim Mode in Zsh
- Press `Esc` to enter normal mode
- `hjkl` for navigation in normal mode
- Useful emacs bindings preserved in insert mode:
  - `Ctrl+a/e`: Beginning/end of line
  - `Ctrl+r`: Reverse search
  - `Ctrl+p/n`: Previous/next command

## Customization

All configs are in `~/.dotfiles` and organized by tool:
```
~/.dotfiles/
├── bash/.bashrc          # Bash configuration
├── zshrc/.zshrc          # Zsh configuration
├── tmux/.tmux.conf       # Tmux configuration
├── nvim/.config/nvim/    # Neovim configuration
└── install.sh            # Installation script
```

Edit configs, commit changes, and pull on other machines to sync your environment.

## Platform Support

- ✅ Linux (Ubuntu/Debian tested, others should work)
- ✅ macOS (Apple Silicon and Intel)
- ✅ WSL2 (tested and working)

## Troubleshooting

### Colors not displaying correctly
Make sure your terminal emulator supports 256 colors and true color. For tmux:
```bash
# Kill all tmux sessions and restart
tmux kill-server
tmux
```

### Homebrew not found after install
Restart your shell completely:
```bash
exec zsh
# or
exec bash
```

### Icons not displaying
Ensure your terminal uses a [Nerd Font](https://www.nerdfonts.com/). The Starship and nvim configurations use icons extensively.

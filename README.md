# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/). Each directory is a stow package -- see its `README.md` for details.

## Tools

| Package | Description |
|---------|-------------|
| [aerospace](aerospace/) | Tiling window manager (macOS) |
| [claude](claude/) | Claude Code CLI (statusline, local settings) |
| [fish](fish/) | Shell with abbreviations, aliases, integrations |
| [ghostty](ghostty/) | Terminal emulator |
| [git](git/) | Git config with delta pager |
| [helix](helix/) | Modal text editor with LSP |
| [karabiner](karabiner/) | Keyboard customizer (macOS) |
| [lazygit](lazygit/) | Terminal git UI |
| [nvim](nvim/) | Neovim (kickstart.nvim based) |
| [starship](starship/) | Shell prompt |
| [tmux](tmux/) | Terminal multiplexer (image-passthrough capable) |
| [yazi](yazi/) | Terminal file manager |
| [zed](zed/) | Code editor with Vim mode |
| [zellij](zellij/) | Terminal multiplexer (modern) |

**Theme:** Catppuccin Mocha across all tools.

## Install

```sh
# Prerequisites
brew install stow fish starship ghostty helix yazi lazygit git-delta fzf zoxide eza neovim zellij tmux

# macOS only
brew install --cask nikitabobko/tap/aerospace karabiner-elements
brew install borders

# Font
brew install --cask font-jetbrains-mono-nerd-font

# Clone and stow
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
stow */
```

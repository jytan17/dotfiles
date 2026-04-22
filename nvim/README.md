# Neovim

Modal text editor configured with kickstart.nvim as a base. Built up incrementally.

## Setup

```sh
stow nvim
```

On first launch, lazy.nvim will auto-install all plugins. Run `:checkhealth` to verify.

## Dependencies / External Setup

- [Neovim](https://neovim.io/) >= 0.10 -- `brew install neovim`
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) -- for icons

## File Structure

| File | Purpose |
|------|---------|
| `.config/nvim/init.lua` | Single-file config (kickstart.nvim based) |

## Notable Settings

- **Leader:** Space
- **Relative line numbers** enabled
- **Clipboard sync** with system clipboard
- **Undo persistence** across sessions
- **Cursor line** highlighted
- **Scroll offset** of 10 lines
- **Smart case** search

## Theme / Appearance

Not yet configured.

# tmux

Terminal multiplexer for managing multiple shell sessions, panes, and windows within a single terminal. Config lives at `~/.config/tmux/tmux.conf`.

## Setup

1. Stow from the dotfiles root: `stow tmux`
2. Install TPM: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
3. Open tmux and press `prefix + I` to install plugins

## Dependencies / External Setup

- [TPM](https://github.com/tmux-plugins/tpm) -- must be cloned manually to `~/.tmux/plugins/tpm` (not managed by stow)

## File Structure

| File | Purpose |
|------|---------|
| `.config/tmux/tmux.conf` | Main tmux configuration |

## Key Bindings

Prefix is `Ctrl-Space` (remapped from default `Ctrl-b`).

| Keys | Action |
|------|--------|
| `prefix + c` | New window |
| `prefix + \|` | Vertical split (in current path) |
| `prefix + -` | Horizontal split (in current path) |
| `Ctrl-h/j/k/l` | Navigate panes (no prefix needed) |
| `prefix + m` | Toggle pane zoom |
| `prefix + r` | Reload config |
| `prefix + $` | Rename session |
| `prefix + I` | Install TPM plugins |

Note: default `prefix + z` for zoom is unbound.

## Plugins

Managed via TPM.

| Plugin | Description |
|--------|-------------|
| tmux-sensible | Sane defaults |
| tmux-resurrect | Save/restore sessions across restarts |
| tmux-continuum | Auto-save and auto-restore sessions |
| catppuccin/tmux | Status bar theme |

## Notable Settings

- **Mouse** enabled for scrolling, pane resize, and window selection
- **Base index 1** for windows and panes
- **Scrollback** set to 50,000 lines
- **Escape delay** set to 0ms for snappy neovim usage
- **True color** (24-bit) and undercurl terminal overrides
- **Auto rename** windows to the currently running program

## Theme / Appearance

Catppuccin Mocha with rounded window tabs and transparent status bar background. Status bar shows session name and date/time on the right.

- Session indicator is **green** normally, **red** when prefix is active

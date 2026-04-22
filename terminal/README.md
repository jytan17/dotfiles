# Terminal

Custom terminfo entries for proper terminal feature support (undercurl, colored underlines) across multiplexers like Zellij.

## Setup

This package doesn't use `stow` — run the setup script directly:

```sh
./terminal/setup.sh
```

This compiles the terminfo entries into `~/.terminfo/`, which takes priority over system entries.

## Dependencies / External Setup

- `tic` (ncurses) — should be pre-installed on most systems

## File Structure

| File | Purpose |
|------|---------|
| `undercurl.terminfo` | Extends `xterm-256color` with `Smulx` (styled underlines) and `Setulc` (underline color) capabilities |
| `setup.sh` | Compiles the terminfo source into `~/.terminfo/` |

## Notable Settings

- **Smulx**: Enables styled underlines (curly, dotted, dashed) — needed for diagnostic undercurl in Neovim
- **Setulc**: Enables colored underlines (RGB) — needed for colored diagnostic squiggles
- Overrides the default `xterm-256color` entry so it works automatically inside Zellij/tmux without changing `$TERM`

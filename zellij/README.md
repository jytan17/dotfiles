# Zellij

Terminal multiplexer with built-in session management. Uses `Ctrl-Space` as prefix (tmux-like mode) with vim-style navigation.

## Setup

```sh
stow zellij
```

## Dependencies / External Setup

- [zellij](https://zellij.dev/) -- `brew install zellij`
- [vim-zellij-navigator](https://github.com/hiasr/vim-zellij-navigator) WASM plugin -- bundled in `plugins/` directory

## File Structure

| File | Purpose |
|------|---------|
| `.config/zellij/config.kdl` | Main configuration |
| `.config/zellij/layouts/default.kdl` | Default layout with zjstatus status bar |
| `.config/zellij/plugins/vim-zellij-navigator.wasm` | WASM plugin for seamless nvim/zellij pane navigation |
| `.config/zellij/plugins/zjstatus.wasm` | Custom status bar plugin |

## Key Bindings

### Navigation (no prefix, always active)

| Keys | Action |
|------|--------|
| `Ctrl-h/j/k/l` | Navigate panes (nvim-aware via vim-zellij-navigator) |
| `Alt-h/j/k/l` | Resize panes (nvim-aware) |

### Prefix Mode (`Ctrl-Space` then...)

| Keys | Action |
|------|--------|
| `c` | New tab |
| `\|` | Vertical split |
| `-` | Horizontal split |
| `m` | Toggle pane zoom (fullscreen) |
| `x` | Close pane |
| `X` | Close tab |
| `[` / `]` | Swap pane backward/forward |
| `1-9` | Go to tab by number |
| `Space` | Toggle last tab |
| `w` | Session manager (picker) |
| `$` / `.` | Rename tab / rename pane |
| `f` | Toggle floating panes |
| `F` | New floating pane (scratch terminal) |
| `b` | Toggle pane frames |
| `/` | Cycle swap layout (toggle stacked/tiled, like aerospace `alt+/`) |
| `,` | Toggle pane embed/floating (like aerospace `alt+,`) |
| `n` / `p` | Focus next/previous pane (cycle within stack) |
| `H/J/K/L` | Move focused pane left/down/up/right |
| `r` | Enter resize mode |
| `e` | Edit scrollback in `$EDITOR` |
| `d` | Detach session |
| `[` | Enter scroll/copy mode |
| `g` | Enter locked mode (passthrough all keys) |
| `Esc` | Cancel prefix |

### Resize Mode (`prefix + r` to enter)

Keys are repeatable -- no need to re-enter the mode.

| Keys | Action |
|------|--------|
| `h/j/k/l` | Increase size left/down/up/right |
| `H/J/K/L` | Decrease size left/down/up/right |
| `=` / `-` | Increase / decrease evenly |
| `Esc` / `Enter` | Exit resize mode |

### Scroll/Copy Mode

| Keys | Action |
|------|--------|
| `j` / `k` | Scroll down/up |
| `Ctrl-d` / `Ctrl-u` | Half page down/up |
| `/` | Search |
| `n` / `N` | Next/previous search result |
| `q` / `Esc` | Exit scroll mode |

### Locked Mode

| Keys | Action |
|------|--------|
| `Ctrl-Space` | Exit locked mode |

## Plugins

| Plugin | Purpose |
|--------|---------|
| vim-zellij-navigator (v0.3.0) | Detects nvim in focused pane, routes Ctrl-h/j/k/l between zellij panes and nvim splits seamlessly |
| zjstatus | Custom status bar with three-section layout (left/center/right), Catppuccin colors, git branch, datetime |

## Notable Settings

- **Theme:** Catppuccin Mocha
- **Shell:** Fish
- **Mouse** enabled
- **Copy on select** enabled
- **Clickable URLs** enabled (Ctrl-click to open)
- **Scrollback:** 50,000 lines
- **Session serialization** enabled (auto-save/restore sessions)
- **Pane frames** disabled (cleaner look)
- **Layout:** Custom default with zjstatus status bar
- **Swap layouts:** Vertical (side by side), Horizontal (top to bottom), Stacked (main + accordion) -- cycled with `prefix + /`

## Theme / Appearance

- **Theme:** Catppuccin Mocha (built-in)
- **Status bar:** zjstatus with three sections:
  - **Left:** Mode indicator (color-coded) + session name (blue)
  - **Center:** Tab list (active tab highlighted)
  - **Right:** Git branch (green) + time
- **Mode colors:** Normal (blue), Prefix (yellow), Locked (red), Scroll (green), Search (pink), Rename (peach), Resize (mauve)
- **Pane frames** off for a cleaner look

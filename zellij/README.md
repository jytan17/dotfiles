# Zellij

Terminal multiplexer with built-in session management. Uses `Ctrl-Space` as prefix (tmux-like mode) with vim-style navigation.

## Setup

```sh
stow zellij
```

## Dependencies / External Setup

- [zellij](https://zellij.dev/) -- `brew install zellij`
- WASM plugins bundled in `plugins/` directory (no manual install needed)

## File Structure

| File | Purpose |
|------|---------|
| `.config/zellij/config.kdl` | Main configuration (keybindings, settings) |
| `.config/zellij/layouts/default.kdl` | Default layout with zjstatus status bar and swap layouts |
| `.config/zellij/plugins/vim-zellij-navigator.wasm` | Nvim-aware pane navigation |
| `.config/zellij/plugins/zjstatus.wasm` | Custom status bar |

## Key Bindings

### Navigation (no prefix, always active)

| Keys | Action |
|------|--------|
| `Ctrl-h/j/k/l` | Navigate panes (nvim-aware via vim-zellij-navigator) |
| `Alt-h/j/k/l` | Resize panes (nvim-aware via smart-splits) |

### Prefix Mode (`Ctrl-Space` then...)

#### Panes

| Keys | Action |
|------|--------|
| `\|` | Vertical split |
| `-` | Horizontal split |
| `m` | Toggle pane zoom (fullscreen) |
| `x` | Close pane |
| `n` / `p` | Focus next / previous pane |
| `H/J/K/L` | Move focused pane left/down/up/right |
| `.` | Rename pane |

#### Tabs

| Keys | Action |
|------|--------|
| `c` | New tab |
| `X` | Close tab |
| `1-9` | Go to tab by number |
| `Space` | Toggle last tab |
| `$` | Rename tab |

#### Floating

| Keys | Action |
|------|--------|
| `f` | Toggle floating panes (creates one if none exist) |
| `F` | Convert focused pane between floating/embedded |
| `,` | Toggle pane embed/floating (aerospace-style) |

#### Layouts (aerospace-inspired)

| Keys | Action |
|------|--------|
| `/` | Cycle layout: vertical, horizontal, stacked |
| `b` | Toggle pane frames (borders) |

#### Session / Modes

| Keys | Action |
|------|--------|
| `w` | Session manager (picker) |
| `d` | Detach session |
| `r` | Enter resize mode |
| `e` | Edit scrollback in `$EDITOR` |
| `[` | Enter scroll/copy mode |
| `g` | Enter locked mode (passthrough all keys) |
| `Esc` | Cancel prefix |

### Resize Mode (`prefix + r`)

Keys are repeatable -- no need to re-enter the mode.

| Keys | Action |
|------|--------|
| `h/j/k/l` | Increase size left/down/up/right |
| `H/J/K/L` | Decrease size left/down/up/right |
| `=` / `-` | Increase / decrease evenly |
| `Esc` / `Enter` | Exit resize mode |

### Scroll/Copy Mode (`prefix + [`)

| Keys | Action |
|------|--------|
| `j` / `k` | Scroll down/up |
| `Ctrl-d` / `Ctrl-u` | Half page down/up |
| `/` | Search |
| `n` / `N` | Next / previous search result |
| `q` / `Esc` | Exit scroll mode |

### Locked Mode (`prefix + g`)

All keys pass through to the terminal. Exit with `Ctrl-Space`.

## Plugins

| Plugin | Purpose |
|--------|---------|
| vim-zellij-navigator (v0.3.0) | Detects nvim in focused pane, routes Ctrl-h/j/k/l between zellij panes and nvim splits seamlessly |
| zjstatus | Custom status bar with Catppuccin colors, git branch, datetime |

## Notable Settings

- **Shell:** Fish
- **Mouse** enabled
- **Copy on select** enabled
- **Clickable URLs** enabled (Ctrl-click to open)
- **Scrollback:** 50,000 lines
- **Session serialization** enabled (auto-save/restore)
- **Pane frames** disabled by default
- **Auto-accept plugin permissions** enabled
- **Swap layouts:** Vertical (side by side), Horizontal (top to bottom), Stacked (main + accordion)

## Theme / Appearance

- **Theme:** Catppuccin Mocha (built-in)
- **Status bar (zjstatus):**
  - **Left:** Mode indicator (color-coded) + session name
  - **Center:** Tab list (active tab highlighted)
  - **Right:** Git branch + time
- **Mode colors:** Normal (blue), Prefix (yellow), Locked (red), Scroll (green), Search (pink), Rename (peach), Resize (mauve)

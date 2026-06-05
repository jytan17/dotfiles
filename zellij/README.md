# Zellij

Terminal multiplexer with built-in session management. Uses `Ctrl-,` as prefix (tmux-like mode) with vim-style navigation.

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

### Prefix Mode (`Ctrl-,` then...)

#### Panes

| Keys | Action |
|------|--------|
| `\|` | Vertical split |
| `-` | Horizontal split |
| `=` | Stacked split (accordion) |
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
| `/` | Cycle swap layout: vertical, horizontal, stacked |
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

All keys pass through to the terminal. `Ctrl-,` goes directly to prefix mode (single tap, no need to unlock first). This is important for Neovim integration — `zellij-autolock` puts Zellij in locked mode when Neovim is focused, so `Ctrl-,` is all you need to access Zellij actions from inside Neovim.

## Plugins

| Plugin | Purpose |
|--------|---------|
| vim-zellij-navigator (v0.3.0) | Detects nvim in focused pane, routes Ctrl-h/j/k/l between zellij panes and nvim splits seamlessly |
| zellij-autolock | Auto-locks Zellij when nvim/vim is focused so all keys go to the editor. Loaded via `load_plugins` in config (not as a layout pane) to avoid interfering with swap layouts. |
| zjstatus | Custom status bar with Catppuccin colors, git branch, datetime |

## Notable Settings

- **Shell:** Fish
- **TERM override:** `vte-256color` (required for undercurl in nvim inside zellij -- see [neovim/neovim#31698](https://github.com/neovim/neovim/issues/31698))
- **Styled underlines** enabled (passthrough undercurl escape sequences)
- **Mouse** enabled
- **Copy on select** enabled
- **Clickable URLs** enabled (Ctrl-click to open)
- **Scrollback:** 50,000 lines
- **Session serialization** enabled (auto-save/restore)
- **Pane frames** enabled with rounded corners
- **Auto-accept plugin permissions** enabled
- **Swap layouts:** Vertical, horizontal, stacked (main + accordion). Cycled with prefix+/.

## Quirks

- **Layout pane ordering controls status bar position.** In `default.kdl`, placing the zjstatus plugin pane BEFORE `children` puts the bar at the top; AFTER `children` puts it at the bottom. Currently placed before → top.
- **Autolock must NOT be a layout pane.** Loading `zellij-autolock` as a `pane` in the layout causes swap layout cycling to break (panes get pushed off-screen). It must be loaded via `load_plugins` in `config.kdl` instead.
- **Zellij restart required for layout changes.** Detaching and reattaching is not enough — you must kill all Zellij sessions and start fresh for layout file changes to take effect.
- **`hide_frame_for_single_pane` causes flickering in Ghostty.** This zjstatus option triggers constant layout redraws that Ghostty's GPU renderer exposes as flickering in the main content area. It is set to `false`.

## Theme / Appearance

- **Theme:** Custom `catppuccin-mocha-contrast` (defined in `config.kdl`)
  - Based on Catppuccin Mocha with high-contrast pane frames
  - Focused frame: Catppuccin green (`#A6E3A1`)
  - Unfocused frame: Catppuccin red (`#F38BA8`)
  - Mode-highlight frame: peach/orange (`#FAB387`) -- draws attention during Resize, Scroll, etc.
  - Pane frames use rounded corners
- **Status bar (zjstatus):**
  - **Left:** Mode indicator (color-coded) + session name
  - **Center:** Tab list (active tab highlighted) with contextual indicators
  - **Right:** Git branch + time
- **Tab indicators:** Zoom/fullscreen `[]`, sync `<>` -- plain text appended to tab name when active
- **Mode colors:** Normal (blue), Prefix (peach), Locked (peach), Scroll (green), Search (pink), Rename (peach), Resize (mauve)

# tmux

Terminal multiplexer. Configured to mirror this repo's zellij keybindings (Ctrl-Space prefix, vim-style nav) so muscle memory carries over. Reason for keeping tmux alongside zellij: tmux passes Kitty graphics protocol through to Ghostty, which makes yazi image preview work inside a multiplexer pane.

## Setup

```sh
stow tmux
```

First-time setup (TPM clone + plugin install):

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux                       # start a session
# inside tmux:
prefix + I                 # install plugins (Ctrl-Space then Shift-i)
```

To pick tmux as your multiplexer for a given Ghostty window, just launch `tmux`. To keep using zellij, launch `zellij`. Both coexist; the nvim config detects which one is active and loads the matching navigation plugin.

## Dependencies / External Setup

- [tmux](https://github.com/tmux/tmux) >= 3.3 -- `brew install tmux` (3.3 required for `allow-passthrough`)
- [TPM](https://github.com/tmux-plugins/tpm) -- cloned into `~/.config/tmux/plugins/tpm`
- [Ghostty](https://ghostty.org/) -- terminal emulator (Kitty graphics protocol source)
- `xterm-ghostty` terminfo entry -- copy from app bundle if missing:
  ```sh
  mkdir -p ~/.terminfo/78
  cp /Applications/Ghostty.app/Contents/Resources/terminfo/78/xterm-ghostty ~/.terminfo/78/
  ```

## File Structure

| File | Purpose |
|------|---------|
| `.config/tmux/tmux.conf` | All tmux config: keybindings, terminal features, plugins, theme |

## Key Bindings

Prefix: `Ctrl-Space`. Designed to match this repo's zellij bindings.

### Navigation (no prefix, always active)

| Keys | Action |
|------|--------|
| `Ctrl-h/j/k/l` | Navigate panes (nvim-aware via vim-tmux-navigator). Hard stop at edges -- pressing toward the boundary on the outermost pane does nothing. |
| `prefix + h/j/k/l` | Resize pane left/down/up/right (repeatable within 600ms) |

### Prefix mode (`Ctrl-Space` then...)

#### Panes

| Keys | Action |
|------|--------|
| `\|` | Vertical split |
| `-` | Horizontal split |
| `=` | Switch to `main-vertical` layout (closest to zellij stacked) |
| `m` | Toggle pane zoom (fullscreen) |
| `x` | Close pane |
| `n` / `p` | Next / previous pane |
| `H/J/K/L` | Swap focused pane with neighbor (left/down/up/right) |
| `[` / `]` | Move pane backwards / forwards in window order |
| `.` | Rename pane title |

#### Tabs (windows)

| Keys | Action |
|------|--------|
| `c` | New window |
| `X` | Close window |
| `1-9` | Go to window N |
| `Space` | Last window |
| `$` | Rename window |

#### Floating

| Keys | Action |
|------|--------|
| `f` | Toggle floating shell (native `display-popup`). Ctrl-d or `exit` closes it. |
| `F` | Break current pane out into its own window |

#### Layouts

| Keys | Action |
|------|--------|
| `/` | Cycle layout (`next-layout`) |
| `b` | Toggle pane border title bar (rough analogue of zellij frames) |

#### Session / modes

| Keys | Action |
|------|--------|
| `w` | Session picker (native `choose-tree`) |
| `d` | Detach session |
| `e` | Capture scrollback to a tempfile and open in `$EDITOR` |
| `[` | Enter copy mode |
| `R` | Reload `tmux.conf` |

### Resizing

Direct on prefix, no mode-switch. `-r` flag means after one prefix press you can tap arrows in succession within 600ms without re-pressing prefix.

| Keys | Action |
|------|--------|
| `prefix + Up/Down/Left/Right` | Resize 5 cells in that direction (repeatable) |
| `prefix + =` | Even out splits on the current axis (`select-layout -E`) |

### Copy mode (`prefix + [`)

Vi-style.

| Keys | Action |
|------|--------|
| `v` | Begin selection |
| `y` / `Enter` | Copy to system clipboard (pbcopy) |
| `Ctrl-d` / `Ctrl-u` | Half page down/up |
| `Esc` / `q` | Exit copy mode |

## Plugins

| Plugin | Purpose |
|--------|---------|
| tpm | Plugin manager |
| tmux-sensible | Sensible defaults |
| vim-tmux-navigator | nvim-aware `Ctrl-h/j/k/l` between tmux panes and nvim splits |
| tmux-yank | Yank to system clipboard |
| tmux-resurrect | Save/restore sessions across reboots (manual: `prefix + Ctrl-s` to save, `prefix + Ctrl-r` to restore) |
| catppuccin/tmux | Status line theme (mocha flavor, rounded window separators) |

## Notable Settings

- **Prefix:** `Ctrl-Space` (matches zellij)
- **Default terminal inside tmux:** `tmux-256color`
- **Truecolor + undercurl:** advertised via `terminal-features` for `xterm-ghostty`, with explicit `Smulx`/`Setulc` overrides as a fallback so nvim curly underlines render
- **`allow-passthrough on`:** lets Ghostty's Kitty graphics protocol reach yazi (image preview works inside tmux panes)
- **Mouse, focus events, set-clipboard, 50k scrollback** all on
- **`escape-time 0`:** removes nvim ESC latency
- **`base-index 1`, `pane-base-index 1`, `renumber-windows on`:** tab-style numbering
- **`detach-on-destroy off`:** killing the last window in a session jumps you to the next session instead of dropping back to the shell
- **Clipboard:** copy-mode `y` uses `pbcopy` directly (macOS)

## Quirks

- **Floating shell is native, not a plugin.** `prefix + f` runs `display-popup -E` which spawns a shell in the current pane's directory. Ctrl-d or `exit` closes the popup cleanly. Border styling comes from `popup-border-style` / `popup-border-lines` (mauve, single line) -- matching the catppuccin theme. `F` still breaks the current pane into its own window.
- **No native stacked/accordion layout.** `=` switches to `main-vertical` -- visually similar but mechanically different.
- **No locked mode.** zellij's autolock isn't needed because vim-tmux-navigator detects nvim by process name (`#{pane_current_command}`), so `Ctrl-h/j/k/l` correctly stays inside nvim when nvim is focused.
- **TPM lives outside the stow package.** It's cloned into `~/.config/tmux/plugins/tpm` directly. Stow folds in `tmux.conf` next to the existing `plugins/` dir without conflict.
- **`xterm-ghostty` terminfo is a separate install.** macOS ncurses doesn't ship with it; copy the compiled entry from the Ghostty app bundle into `~/.terminfo/` (see Setup).

## Theme / Appearance

- **Theme:** [catppuccin/tmux](https://github.com/catppuccin/tmux), `mocha` flavor
- **Pane borders:** active = mocha mauve `#cba6f7`, inactive = mocha surface_1 `#45475a`, `pane-border-lines single`
- **Status bar (top, centre-justified):**
  - **Left:** `session`
  - **Centre:** window list -- catppuccin `rounded` style, number on right of name, icon flags
  - **Right:** clock (`%H:%M`) via the catppuccin `date_time` module with `@catppuccin_date_time_text` overridden
- **Popup (native float):** `popup-border-style fg=#cba6f7` (mauve, matches active border), single-line border, transparent bg

To switch flavor edit `@catppuccin_flavor` in `tmux.conf` (`latte`, `frappe`, `macchiato`, `mocha`). To swap modules, edit the `set -ag status-left` / `status-right` block after `run tpm`.

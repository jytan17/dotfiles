# Ghostty

GPU-accelerated terminal emulator. Minimal config focused on font, theme, and cursor behavior.

## Setup

```sh
stow ghostty
```

## Dependencies / External Setup

- [Ghostty](https://ghostty.org/) -- install from the official site
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) -- `brew install font-jetbrains-mono-nerd-font`

## File Structure

| File | Purpose |
|------|---------|
| `.config/ghostty/config` | Main Ghostty configuration |
| `.config/ghostty/shaders/cursor_warp.glsl` | Faded warp trail shader (Neovide-like) |
| `.config/ghostty/shaders/ripple_cursor.glsl` | Ripple effect on cursor mode change |

## Notable Settings

| Setting | Value | Notes |
|---------|-------|-------|
| `font-family` | JetBrainsMono Nerd Font | Includes ligatures and Nerd Font icons |
| `font-size` | 15 | |
| `font-style` | default | Ghostty built-in default style |
| `term` | `xterm-ghostty` | Enables styled underlines (curly, dotted, dashed) |
| `cursor-style` | block | Always a block cursor |
| `shell-integration-features` | `no-cursor` | Prevents shell from changing cursor style |
| `macos-option-as-alt` | `true` | Option key sends Alt/Meta escape sequences (enables Opt+Backspace word delete, Opt+Arrow word jump, etc.) |
| `custom-shader` | `cursor_warp.glsl`, `ripple_cursor.glsl` | Faded warp trail + ripple on mode change |
| `custom-shader-animation` | `always` | Keeps animation running even when unfocused |

## Theme / Appearance

- **Theme:** Catppuccin Mocha (built-in)
- **Font:** JetBrainsMono Nerd Font, size 15, default style
- **Cursor:** Block, never changes (shell integration cursor disabled)

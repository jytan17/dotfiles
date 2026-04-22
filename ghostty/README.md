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

## Notable Settings

| Setting | Value | Notes |
|---------|-------|-------|
| `font-family` | JetBrainsMono Nerd Font | Includes ligatures and Nerd Font icons |
| `font-size` | 15 | |
| `font-style` | Bold | All regular text renders bold |
| `term` | `xterm-ghostty` | Enables styled underlines (curly, dotted, dashed) |
| `cursor-style` | block | Always a block cursor |
| `shell-integration-features` | `no-cursor` | Prevents shell from changing cursor style |

## Theme / Appearance

- **Theme:** Catppuccin Mocha (built-in)
- **Font:** JetBrainsMono Nerd Font, size 15, bold
- **Cursor:** Block, never changes (shell integration cursor disabled)

# AeroSpace

Tiling window manager for macOS. Uses `alt` as the primary modifier with arrow-key navigation.

## Setup

```sh
stow aerospace
```

## Dependencies / External Setup

- [AeroSpace](https://github.com/nikitabobko/AeroSpace) -- install via `brew install --cask nikitabobko/tap/aerospace`
- [JankyBorders](https://github.com/FelixKratz/JankyBorders) -- launched automatically on startup for window border highlighting (`brew install borders`)

## File Structure

| File | Purpose |
|------|---------|
| `.config/aerospace/aerospace.toml` | Main AeroSpace configuration |

## Key Bindings

### Main Mode

| Keys | Action |
|------|--------|
| `alt + ←/↓/↑/→` | Focus window left/down/up/right |
| `alt + shift + ←/↓/↑/→` | Move window left/down/up/right |
| `alt + 1-9` | Switch to workspace 1-9 |
| `alt + shift + 1-9` | Move window to workspace 1-9 |
| `alt + m` | Toggle fullscreen |
| `alt + /` | Toggle horizontal/vertical tiling |
| `alt + ,` | Toggle horizontal/vertical accordion |
| `alt + shift + f` | Toggle floating/tiling |
| `alt + shift + b` | Balance (equalize) window sizes |
| `alt + shift + -/=` | Shrink/grow window by 50 |
| `alt + v` | Join with right window (vertical) |
| `alt + s` | Join with bottom window (horizontal) |
| `alt + ctrl + ←/→` | Focus left/right monitor |
| `alt + ctrl + shift + ←/→` | Move window to left/right monitor |
| `alt + shift + ;` | Enter service mode |

### Service Mode

| Keys | Action |
|------|--------|
| `esc` | Reload config, return to main mode |
| `r` | Flatten workspace tree, return to main mode |
| `alt + shift + ←/↓/↑/→` | Join with adjacent window, return to main mode |

## Notable Settings

- **Start at login** enabled
- **Normalization** -- flatten containers and opposite orientation for nested containers
- **Mouse follows focus** -- cursor moves to center of focused monitor
- **Gaps** -- 10px uniform gaps on all sides
- **9 workspaces** configured

## Theme / Appearance

Window borders provided by JankyBorders:

| Element | Color |
|---------|-------|
| Active window border | `#58a6ff` (blue) |
| Inactive window border | `#494d64` (muted gray, Catppuccin Surface 1) |
| Border width | 8px |

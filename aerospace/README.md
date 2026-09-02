# AeroSpace

Tiling window manager for macOS. Prefix is `alt`. Directions bound to both Colemak-DH `mnei` and QWERTY `hjkl` (same physical keys on right home row) so bindings work on external Colemak-DH keyboard and laptop QWERTY keyboard. One unified **move mode** handles all pane relocation, monitor jumps, workspace moves, and tree restructuring.

## Setup

```sh
stow aerospace
```

## Dependencies / External Setup

- [AeroSpace](https://github.com/nikitabobko/AeroSpace) -- `brew install --cask nikitabobko/tap/aerospace`
- [JankyBorders](https://github.com/FelixKratz/JankyBorders) -- `brew install borders`. Recolored when entering move mode.

## File Structure

| File | Purpose |
|------|---------|
| `.config/aerospace/aerospace.toml` | Main AeroSpace configuration |

## Key Bindings

### Main Mode

| Keys | Action |
|------|--------|
| `alt + m/n/e/i` or `alt + h/j/k/l` | Focus window left/down/up/right |
| `alt + 1-9` | Switch workspace 1-9 |
| `alt + f` | Zoom (fullscreen toggle) |
| `alt + b` | Balance sizes |
| `alt + shift + -/=` | Shrink/grow window by 50 |
| `alt + shift + M` | Enter **move** mode |

### Move Mode

Border turns **orange** (`#ff9e64`). Sticky.

Rules inside the mode:
- **plain `mnei` / `hjkl`** = focus window (look)
- **`shift + mnei` / `shift + hjkl`** = move window (commit)
- **`ctrl + mnei` / `ctrl + hjkl`** = join with pane in that direction (restructure tree)

| Keys | Action |
|------|--------|
| `m/n/e/i` or `h/j/k/l` | Focus window left/down/up/right |
| `shift + m/n/e/i` or `shift + h/j/k/l` | Move window left/down/up/right |
| `ctrl + m/n/e/i` or `ctrl + h/j/k/l` | Join with pane left/down/up/right |
| `←/↓/↑/→` | Focus monitor left/down/up/right |
| `shift + ←/↓/↑/→` | Move window to monitor left/down/up/right |
| `1-9` | Switch workspace 1-9 |
| `shift + 1-9` | Move window to workspace 1-9 |
| `t` | Layout horizontal tiles |
| `v` | Layout vertical tiles |
| `a` | Layout accordion toggle |
| `f` | Toggle float/tile |
| `b` | Balance sizes |
| `x` | Flatten workspace tree |
| `w` | Close focused window |
| `r` | Reload config |
| `esc` / `enter` | Exit to main |

## Notable Settings

- **Modal design** — `mnei` (Colemak-DH) and `hjkl` (QWERTY) both mean directions; base layer focuses windows, move mode extends with shift (move) and ctrl (join) tiers.
- **Sticky move mode** — chain multiple ops without re-entering. `esc`/`enter` exits.
- **Border feedback** — active border swaps to orange in move mode.
- **Start at login** enabled
- **Normalization** — flatten containers, opposite orientation for nested containers
- **Mouse follows focus** — cursor moves to center of focused monitor
- **Gaps** — 10px uniform
- **9 workspaces**

## Known Conflicts

Aerospace grabs bindings globally.

- **macOS Option dead keys lost**: `alt+e` (´), `alt+i` (ˆ), `alt+n` (˜) — no more accented character input. Fine for English-only.
- **Readline word-motion lost**: `alt+b` (balance) breaks readline backward-word in shells. Trade-off accepted.
- **Unicode symbols lost**: `alt+z`, `alt+m`, `alt+1..9` etc — irrelevant unless you rely on these.
- **Safe**: `option+arrow` word-jump, all `cmd+*`, all `ctrl+*`, function keys.

## Theme / Appearance

| Element | Color |
|---------|-------|
| Active border (main) | `#58a6ff` (blue) |
| Active border (move) | `#ff9e64` (orange) |
| Inactive border | `#494d64` (muted gray, Catppuccin Surface 1) |
| Border width | 8px |

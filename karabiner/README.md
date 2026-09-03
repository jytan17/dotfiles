# Karabiner-Elements

macOS keyboard remapping. Plain JSON config — no Goku dependency.

## Setup

```sh
cd ~/.dotfiles
stow karabiner
brew services start karabiner-elements   # if not already running
open -a "Karabiner-Elements"
```

Grant **Input Monitoring** + **Accessibility** to Karabiner-Elements in System Settings → Privacy & Security on first run.

## Dependencies / External Setup

- `karabiner-elements` (cask) — `brew install --cask karabiner-elements`
- Karabiner-DriverKit-VirtualHIDDevice — installed automatically by Karabiner-Elements

## File Structure

| File | Purpose |
|------|---------|
| `.config/karabiner/karabiner.json` | Karabiner-Elements config |

## Key Bindings

| Keys | Action |
|------|--------|
| `fn + h` | ← left arrow |
| `fn + j` | ↓ down arrow |
| `fn + k` | ↑ up arrow |
| `fn + l` | → right arrow |

All arrow mappings pass through other modifiers (`shift`, `cmd`, `option`, `ctrl`), so combinations like `fn + shift + l` (shift+right = select right) work as expected.

## Notable Settings

- `"optional": ["any"]` on each rule ensures modifier passthrough — e.g. `fn + shift + hjkl` selects text, `fn + cmd + l` does cmd+right (end of line).
- Uses DriverKit (v14+), not kernel extension — compatible with corp-managed Macs.

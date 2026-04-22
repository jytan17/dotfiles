# Karabiner

Keyboard customization tool for macOS. Used for a single dual-role key remapping.

## Setup

```sh
stow karabiner
```

## Dependencies / External Setup

- [Karabiner-Elements](https://karabiner-elements.pqrs.org/) -- `brew install --cask karabiner-elements`

## File Structure

| File | Purpose |
|------|---------|
| `.config/karabiner/karabiner.json` | Main configuration with key remappings and device settings |
| `.config/karabiner/automatic_backups/` | Karabiner-generated config backups |

## Key Bindings

| Input | Tapped | Held |
|-------|--------|------|
| Caps Lock | Escape | Left Control |

Works with any modifier combination (Shift, Option, Command, etc.).

## Notable Settings

- **Virtual keyboard type:** ANSI
- One external device configured as a built-in keyboard (vendor ID 2007) so the same remappings apply to it

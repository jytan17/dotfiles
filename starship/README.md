# Starship

Cross-shell prompt using the Plain Text preset with Catppuccin Mocha colors. All icons are ASCII text -- no Nerd Font required for the prompt itself.

## Setup

```sh
stow starship
```

Starship is initialized in `fish/config.fish` via `starship init fish | source` with `STARSHIP_CONFIG` pointing to this config.

## Dependencies / External Setup

- [starship](https://starship.rs/) -- `brew install starship`

## File Structure

| File | Purpose |
|------|---------|
| `.config/starship/starship.toml` | Prompt configuration -- modules, symbols, colors |

## Notable Settings

- **Preset:** Plain Text -- all symbols are short ASCII labels (e.g., `git`, `py`, `rs`, `aws`)
- **Prompt character:** `>` (green) on success, `x` (red) on error
- **Vim mode indicators:** `<` green (normal), `<` yellow (visual), `<` mauve (replace)
- **Git:** branch truncation with `...`, plain ASCII status symbols (`>` ahead, `<` behind, `<>` diverged)
- **Directory:** read-only marked with `ro`
- **OS:** 50+ OS abbreviations (e.g., `mac`, `ubnt`, `rch`, `fed`, `win`)
- **Battery:** text labels (`full`, `charging`, `discharging`)

## Theme / Appearance

Catppuccin Mocha palette applied throughout:

| Color | Hex | Used For |
|-------|-----|----------|
| Green | `#a6e3a1` | Success, git branch, hostname, Node.js |
| Blue | `#89b4fa` | Directory, Docker, Go, Lua, C/C++ |
| Red | `#f38ba8` | Errors, Java, Ruby |
| Yellow | `#f9e2af` | Git status, AWS, Python, Zig |
| Mauve | `#cba6f7` | cmd_duration, .NET, Kotlin, Terraform |
| Peach | `#fab387` | Package, Rust, Swift |

Bold weight on key elements (prompt character, directory, git branch) for visual hierarchy.

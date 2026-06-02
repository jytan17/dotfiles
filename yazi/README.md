# Yazi

Terminal file manager with vim-style navigation. Configured with a wide preview pane and Catppuccin Mocha theme.

## Setup

```sh
stow yazi
```

Install plugins after stowing:

```sh
ya pkg install
```

## Dependencies / External Setup

- [yazi](https://github.com/sxyazi/yazi) -- `brew install yazi`
- A Nerd Font for icon rendering

## File Structure

| File | Purpose |
|------|---------|
| `.config/yazi/yazi.toml` | Main config -- layout, display, sorting |
| `.config/yazi/keymap.toml` | Custom key binding overrides |
| `.config/yazi/theme.toml` | Flavor/theme selection |
| `.config/yazi/package.toml` | Plugin/flavor dependency manifest |
| `.config/yazi/init.lua` | Plugin initialization (git status setup) |
| `.config/yazi/plugins/smart-enter.yazi/` | Plugin: unified open/enter on `l` |
| `.config/yazi/flavors/catppuccin-mocha.yazi/` | Full Catppuccin Mocha color definitions |

## Key Bindings

| Keys | Action |
|------|--------|
| `l` | Smart enter -- opens file or enters directory (via smart-enter plugin) |
| `<Enter>` | Smart enter -- opens file or enters directory (via smart-enter plugin) |

All other bindings are yazi defaults.

## Plugins

| Plugin | Description |
|--------|-------------|
| smart-enter | Unifies `l` key: enters directories, opens files |
| git | Shows git status indicators (modified, staged, untracked, etc.) next to files |

## Notable Settings

| Setting | Value | Notes |
|---------|-------|-------|
| Column ratio | 2:3:5 | Wide preview pane (50% of screen) |
| Show hidden | `true` | Dotfiles always visible |
| Sort dirs first | `true` | Directories listed before files |
| Sort by | `natural` | Numeric-aware ordering (1, 2, 10 not 1, 10, 2) |

## Theme / Appearance

- **Flavor:** Catppuccin Mocha
- Active tab: dark text on blue background
- Mode indicators: Normal (blue), Select (teal), Unset (rosewater)
- File type colors: images (teal), media (yellow), archives (pink), documents (green), directories (blue)
- Nerd Font icons for common directories and file types
- Syntax-highlighted file previews via bundled tmtheme

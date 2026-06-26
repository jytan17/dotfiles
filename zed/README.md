# Zed

GPU-accelerated code editor with Vim mode, LSP support, and AI integration.

## Setup

```sh
stow zed
```

Install extensions from the Zed marketplace: Catppuccin theme, Material Icon Theme, basedpyright, ruff.

## File Structure

| File | Purpose |
|------|---------|
| `.config/zed/settings.json` | Editor settings -- behavior, AI, theme, fonts, LSP, languages |
| `.config/zed/keymap.json` | Custom key bindings (Vim modes, terminal, project panel, pane nav) |
| `.config/zed/tasks.json` | Runnable tasks (lazygit, lazydocker, yazi) |

## Key Bindings

### Pane Navigation

| Keys | Action |
|------|--------|
| `Ctrl-h/j/k/l` or `Ctrl-←/↓/↑/→` | Navigate panes left/down/up/right |
| `Ctrl-Shift-h/j/k/l` or `Ctrl-Shift-←/↓/↑/→` | Resize pane left/down/up/right |
| `Ctrl-Shift-0` | Reset pane sizes |

### Panels

| Keys | Action |
|------|--------|
| `Ctrl-,` | Toggle terminal panel |

### Vim

| Keys | Action |
|------|--------|
| `g w` | Helix-style jump to word (normal mode) |
| `Shift-s` | Add surrounds (visual mode) |

### Project Panel

| Keys | Action |
|------|--------|
| `l` / `→` | Open entry |
| `h` / `←` | Collapse entry |
| `-` | Parent directory |
| `s` / `v` | Open in horizontal / vertical split |
| `a` / `Shift-a` | New file / directory |
| `r` / `d` | Rename / delete |
| `y` / `x` / `p` | Copy / cut / paste |
| `y p` / `y Shift-p` | Copy relative / absolute path |
| `q` | Toggle left dock |
| `Escape` | Activate next pane |

### Autocomplete (Insert Mode)

| Keys | Action |
|------|--------|
| `Tab` / `Shift-Tab` | Next / previous completion |
| `Ctrl-y` | Confirm completion |

## Plugins

| Extension | Type | Purpose |
|-----------|------|---------|
| Catppuccin | Theme | Color theme |
| Material Icon Theme | Icons | File/folder icons |
| basedpyright | LSP | Python type checking |
| ruff | LSP | Python linting/formatting |

## Notable Settings

| Setting | Value |
|---------|-------|
| Vim mode | Enabled |
| Line numbers | Relative |
| Format on save | Enabled |
| Inline diagnostics | Enabled |
| Inactive pane opacity | 0.7 |
| AI agent model | Claude Sonnet 4 (thinking) via Amazon Bedrock |
| Python LSP | basedpyright + ruff (line length 120, rules E/F/I) |

## Theme / Appearance

- **Theme:** Catppuccin Mocha - No Italics
- **Icons:** Material Icon Theme
- **Font:** JetBrainsMono Nerd Font Mono (buffer: 17, UI: 20)
- **Title bar:** Minimalist (no banners, branch, avatar, or project items)
- **Terminal:** Bottom dock, blinking cursor

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
| `.config/zed/tasks.json` | Runnable tasks (lazygit, lazydocker) |

## Key Bindings

### Pane Navigation (no prefix)

| Keys | Action |
|------|--------|
| `Ctrl-h/j/k/l` | Navigate panes left/down/up/right |
| `Ctrl-,` | Toggle terminal panel |
| `Ctrl-.` | Toggle zoom (maximize pane) |

### Leader (`Space`) Bindings (Vim Normal Mode)

| Keys | Action |
|------|--------|
| `Space e` | Toggle file explorer |
| `Space o` | Toggle project panel focus |
| `Space w` | Save file |
| `Space q` | Close active item |
| `Space /` | Toggle comments |
| `Space f f` | File finder |
| `Space f w` | Project-wide search |
| `Space f b` | Buffer switcher |
| `Space b c` | Close buffer |
| `Space b C` | Close other buffers |
| `Space l a` | Code actions |
| `Space l r` | Rename symbol |
| `Space l d` | Diagnostics panel |
| `Space l f` | Format buffer |
| `Space l h` | Signature help |
| `Space l s/S` | File/project symbols |
| `Space g g` | Git panel |
| `Space g b` | Git blame |
| `Space g d` | Toggle diff hunks |
| `Space t f` | Toggle terminal focus |
| `Space t t` | New terminal |
| `Space s v/h` | Split right/down |
| `Space n/p + h/d/f/c` | Next/prev hunk/diagnostic/function/class |

### Project Panel

| Keys | Action |
|------|--------|
| `l` / `o` | Open entry |
| `h` | Collapse entry |
| `-` | Parent directory |
| `a` / `Shift-a` | New file / directory |
| `r` / `d` | Rename / delete |
| `y` / `x` / `p` | Copy / cut / paste |
| `s` / `v` | Open in horizontal / vertical split |

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
| Python LSP | basedpyright + ruff (line length 88, rules E/F/I) |

## Theme / Appearance

- **Theme:** Catppuccin Mocha - No Italics
- **Icons:** Material Icon Theme
- **Font:** JetBrainsMono Nerd Font Mono (buffer: 17, UI: 20)
- **Title bar:** Minimalist (no banners, branch, avatar, or project items)
- **Terminal:** Bottom dock, blinking cursor

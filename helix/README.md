# Helix

Modal text editor with built-in LSP support. Keyboard-only workflow with no custom keybindings -- uses all defaults.

## Setup

```sh
stow helix
```

## Dependencies / External Setup

Language servers (install as needed):

- [basedpyright](https://github.com/DetachHead/basedpyright) -- Python type checking
- [ruff](https://github.com/astral-sh/ruff) -- Python linting/formatting
- [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
- [vscode-json-language-server](https://github.com/hrsh7th/vscode-langservers-extracted)
- [docker-langserver](https://github.com/rcjsuen/dockerfile-language-server-nodejs)
- [docker-compose-langserver](https://github.com/microsoft/compose-language-service)
- [taplo](https://github.com/tamasfe/taplo) -- TOML
- [marksman](https://github.com/artempyanykh/marksman) -- Markdown

## File Structure

| File | Purpose |
|------|---------|
| `.config/helix/config.toml` | Editor settings, cursor shapes, statusline, LSP, indent guides |
| `.config/helix/languages.toml` | Language server definitions and per-language settings |

## Notable Settings

| Setting | Value | Notes |
|---------|-------|-------|
| Line numbers | Relative | For vim-style jump motions |
| Mouse | Disabled | Keyboard-only |
| Idle timeout | 50ms | Very responsive autocomplete (default 250ms) |
| Completion trigger | 1 character | Triggers after a single keystroke |
| Auto signature help | Enabled | Shows function signatures while typing |
| Indent guides | `┊` character | Thin dotted vertical lines |
| Cursor shapes | Block (normal), Bar (insert), Underline (select) | |

## Plugins

Helix has no plugin system. Extended functionality is via language servers:

| Language | Server(s) | Auto-Format | Formatter |
|----------|-----------|-------------|-----------|
| Python | basedpyright + ruff | Yes | `ruff format` |
| JSON | vscode-json-language-server | Yes | Built-in |
| YAML | yaml-language-server | Yes | Built-in |
| TOML | taplo | Yes | Built-in |
| Markdown | marksman | No | -- |
| Dockerfile | docker-langserver | -- | -- |
| Docker Compose | docker-compose-langserver + yaml-language-server | Yes | -- |

## Theme / Appearance

- **Theme:** Catppuccin Mocha (built-in)
- **Statusline:** Three-part layout -- mode/git/diagnostics (left), filename (center), position/encoding/filetype (right)
- **Mode labels:** NORMAL, INSERT, SELECT

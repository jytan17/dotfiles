# Claude Code

Configuration for [Claude Code](https://docs.claude.com/en/docs/claude-code) — Anthropic's CLI coding agent.

## Setup

```sh
cd ~/.dotfiles && stow claude
```

Stow links `claude/.claude/*` into `~/.claude/`. `~/.claude/settings.json` (machine-local, not stowed) references the statusline via its symlinked path.

## File Structure

| File | Purpose |
|------|---------|
| `settings.local.json` | Project-local Claude settings (permissions, allowlists). Symlinked into `~/.claude/`. |
| `statusline-command.sh` | Custom statusline renderer invoked by Claude Code each prompt. |

## Statusline

`statusline-command.sh` reads JSON from stdin (Claude Code passes `workspace`, `model`, `vim` fields) and prints a one-line status:

```
<model>  <dir>  git <branch> <status>  [INSERT|NORMAL]
```

- **Model name** — bold, Catppuccin Mocha Peach.
- **Directory** — bold blue, `$HOME` collapsed to `~`, truncated to 40 chars from the right.
- **Git** — bold green branch; bold yellow status counters (`+staged !modified ?untracked`) matching the Starship glyph set.
- **Vim mode badge** — `INSERT` (green bg) / `NORMAL` (blue bg), only when Vim mode plugin active.

Wired up in `~/.claude/settings.json`:

```json
"statusLine": {
  "type": "command",
  "command": "bash /Users/junyongtan/.claude/statusline-command.sh"
}
```

## Theme / Appearance

Catppuccin Mocha truecolor escapes — matches the rest of the dotfiles (Starship, Helix, Zellij, Ghostty).

## Dependencies

- `jq` — parses the JSON payload from Claude Code.
- `git` — for branch/status info.

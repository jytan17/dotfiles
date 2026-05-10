# Pi

[Pi](https://pi.dev) — minimal terminal coding agent by Earendil. Four built-in tools (read, write, edit, bash), TypeScript extensions, MCP support, branching sessions, 30+ LLM providers.

## Setup

```bash
stow pi
```

Symlinks `~/.pi/agent/settings.json` to the file in this package. `auth.json` is **not** tracked (contains OAuth tokens / API keys).

## Dependencies / External Setup

- `pi` CLI installed (`npm i -g @earendil-works/pi-coding-agent` or curl installer from pi.dev)
- API key or OAuth login for at least one provider

### Authentication

Either:

```bash
pi              # then /login for OAuth providers (Anthropic, ChatGPT, Copilot)
```

or export an API key env var (e.g. `GEMINI_API_KEY`, `CEREBRAS_API_KEY`, `GROQ_API_KEY`, `ANTHROPIC_API_KEY`).

Credentials resolve in order: CLI flag → `~/.pi/agent/auth.json` → env vars.

## File Structure

| File | Purpose |
|------|---------|
| `.pi/agent/settings.json` | Default provider, model, thinking level, changelog version |

Untracked (per-machine):

| File | Purpose |
|------|---------|
| `~/.pi/agent/auth.json` | OAuth tokens and API keys |
| `~/.pi/agent/sessions/` | Session history |

## Notable Settings

- **`defaultProvider`** — provider used when none passed via `--provider`.
- **`defaultModel`** — model ID (e.g. `claude-opus-4-7`, `gemini-2.5-pro`, `qwen-3-coder-480b`).
- **`defaultThinkingLevel`** — `off | minimal | low | medium | high | xhigh`.

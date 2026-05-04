# OpenCode

AI-powered coding assistant CLI tool configuration.

## Setup

```bash
stow opencode
```

This symlinks `~/.config/opencode/` to the config in this package.

## Dependencies / External Setup

- [OpenCode CLI](https://opencode.ai) installed
- A Google account with a Google AI Plus subscription (for Gemini OAuth)
- Node.js (for plugin installation)

### First-time Google Authentication

After stowing, authenticate with your Google account:

```bash
opencode auth login
```

Select **Google** > **OAuth with Google (Gemini CLI)**. A browser window will open for approval.

## File Structure

| File | Purpose |
|------|---------|
| `.config/opencode/opencode.json` | Main config with plugin and provider settings |
| `.config/opencode/themes/catppuccin-mocha.json` | Custom Catppuccin Mocha color theme |

## Plugins

| Plugin | Purpose |
|--------|---------|
| `opencode-gemini-auth` | Authenticates with Google account via OAuth to use existing Gemini plan quotas |

## Notable Settings

- **Google OAuth via plugin**: Uses `opencode-gemini-auth` to authenticate with your Google AI Plus account, allowing use of your subscription quotas directly in OpenCode without separate API billing.
- **No `projectId` configured**: Individual Google AI Plus accounts typically don't need this; the plugin auto-provisions a managed project. Set `provider.google.options.projectId` if you hit quota issues or want to force a specific project.

## Theme / Appearance

Uses a custom **Catppuccin Mocha** theme with full color definitions for UI elements, diff viewer, markdown rendering, and syntax highlighting.

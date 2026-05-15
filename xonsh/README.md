# Xonsh

Python-based shell being evaluated as an alternative to fish. Config mirrors the fish setup as closely as possible.

## Setup

```sh
stow xonsh
```

Then install xonsh and required tools:

```sh
brew install xonsh
pip install xonsh
```

## Dependencies / External Setup

The following tools must be installed for full functionality (same as fish setup):

| Tool | Install |
|------|---------|
| `starship` | `brew install starship` |
| `eza` | `brew install eza` |
| `fzf` | `brew install fzf` |
| `zoxide` | `brew install zoxide` |
| `lazygit` | `brew install lazygit` |
| `lazydocker` | `brew install lazydocker` |
| `nvim` | `brew install neovim` |
| `yazi` | `brew install yazi` |
| `zellij` | `brew install zellij` |
| Rust/Cargo | `curl https://sh.rustup.rs -sSf | sh` |

## File Structure

```
xonsh/
└── .config/
    └── xonsh/
        └── rc.xsh    # Main run control file (XDG-compliant location)
```

## Key Bindings

| Keys | Action |
|------|--------|
| `Ctrl+P` | Search history backward |
| `Ctrl+N` | Search history forward |
| `Ctrl+Y` | Accept autosuggestion |
| `Alt+Backspace` | Delete previous word |

## Notable Settings

- **Abbreviations → aliases:** Fish abbreviations (inline expansion) have no xonsh equivalent. All abbreviations are implemented as regular aliases.
- **Homebrew:** Auto-detected for Apple Silicon (`/opt/homebrew`), Intel Mac (`/usr/local`), and Linuxbrew.
- **Cargo/Rust:** Sourced via `source-bash ~/.cargo/env` if present.
- **Key bindings:** Added via the `events.on_ptk_create` hook using `prompt_toolkit` directly, since xonsh uses ptk as its readline backend.
- **`nf` alias:** Uses `bash -c` wrapper since `$(fzf)` command substitution inside an alias isn't directly composable in xonsh.

## Custom Functions

| Function | Description |
|----------|-------------|
| `mkcd <dir>` | Create directory and cd into it |
| `y [args]` | Yazi file manager — syncs CWD back to shell on exit |
| `bedrock-login` | AWS SSO login for the `bedrock` profile, exports credentials as env vars |

## Theme / Appearance

Prompt is **Starship** using the same `~/.config/starship/starship.toml` as fish (Plain Text preset + Catppuccin Mocha palette). No changes needed to the Starship config.

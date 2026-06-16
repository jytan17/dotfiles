# Fish

Fish shell configuration with abbreviations, aliases, integrations, and custom functions.

## Setup

```sh
stow fish
```

## Dependencies / External Setup

- [fish](https://fishshell.com/) -- `brew install fish`
- [eza](https://github.com/eza-community/eza) -- modern `ls` replacement (`brew install eza`)
- [fzf](https://github.com/junegunn/fzf) -- fuzzy finder (`brew install fzf`)
- [zoxide](https://github.com/ajeetdsouza/zoxide) -- smart `cd` (`brew install zoxide`)
- [starship](https://starship.rs/) -- prompt (`brew install starship`)
- [yazi](https://github.com/sxyazi/yazi) -- terminal file manager (`brew install yazi`)
- [chafa](https://hpjansson.org/chafa/) -- image preview fallback inside Zellij (`brew install chafa`)
- [Rust/Cargo](https://rustup.rs/) -- sourced from `~/.cargo/env.fish`
- [Homebrew](https://brew.sh/) -- auto-detected on macOS and Linux

## File Structure

| File | Purpose |
|------|---------|
| `.config/fish/config.fish` | Main config -- env vars, abbreviations, aliases, integrations, key bindings |
| `.config/fish/fish_variables` | Fish universal variable store |
| `.config/fish/conf.d/rustup.fish` | Auto-sources Rust/Cargo environment |
| `.config/fish/functions/bedrock-login.fish` | AWS SSO login helper for bedrock profile |
| `.config/fish/functions/mkcd.fish` | `mkdir -p` + `cd` in one command |
| `.config/fish/functions/y.fish` | Yazi wrapper with CWD sync on exit; inside Zellij strips Ghostty/Kitty env so yazi falls back to chafa (Zellij no passthrough Kitty graphics) |

## Key Bindings

Default emacs-style key bindings (fish default). Custom bindings:

| Keys | Action |
|------|--------|
| `Ctrl+P` | Search backward through history |
| `Ctrl+N` | Search forward through history |
| `Ctrl+Y` | Accept autosuggestion / fzf selection |
| `Opt+Backspace` | Delete previous word (macOS-style) |

## Abbreviations

### Git

| Abbr | Expands To |
|------|-----------|
| `g` | `git` |
| `ga` | `git add` |
| `gaa` | `git add --all` |
| `gb` | `git branch` |
| `gcm` | `git commit -m` |
| `gco` | `git checkout` |
| `gd` | `git diff` |
| `glog` | `git log --oneline --decorate --color --graph` |
| `gloga` | `git log --oneline --decorate --graph --all` |
| `gpl` | `git pull` |
| `gps` | `git push` |
| `grs` | `git restore` |
| `gs` | `git status` |
| `gsw` | `git switch` |
| `gswc` | `git switch -c` |

### Tools

| Abbr | Expands To |
|------|-----------|
| `c` | `clear` |
| `e` | `nvim` |
| `lg` | `lazygit` |
| `ld` | `lazydocker` |
| `zj` | `zellij` |
| `vim` / `vi` / `nv` | `nvim` |
| `oc` | `opencode` |

## Aliases

| Alias | Command | Purpose |
|-------|---------|---------|
| `ls` | `eza --icons=always --color=always` | Colorized listing with icons |
| `ll` | `eza -l --icons=always --color=always` | Long listing |
| `la` | `eza -la --icons=always --color=always` | Long listing with hidden files |
| `lt` | `eza --tree --icons=always --color=always` | Tree view |

## Notable Settings

| Setting | Value |
|---------|-------|
| `EDITOR` / `VISUAL` | `nvim` |
| `COLORTERM` | `truecolor` |
| `LANG` / `LC_ALL` | `C.UTF-8` |

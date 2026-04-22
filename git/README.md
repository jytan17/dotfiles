# Git

Global git configuration with delta as the diff pager and modern merge settings.

## Setup

```sh
stow git
```

Create a `~/.gitconfig.local` file for machine-specific settings (user identity, credentials, signing keys). This file is included automatically and is not tracked in the repo.

## Dependencies / External Setup

- [delta](https://github.com/dandavtimer/delta) -- syntax-highlighting pager (`brew install git-delta`)

## File Structure

| File | Purpose |
|------|---------|
| `.gitconfig` | Global git config (pager, diff, merge, includes) |

## Notable Settings

| Setting | Value | Notes |
|---------|-------|-------|
| `core.pager` | `delta` | Replaces default `less` with syntax-highlighted diffs |
| `interactive.diffFilter` | `delta --color-only` | Color-only mode for `git add -p` |
| `delta.navigate` | `true` | `n`/`N` to jump between diff sections |
| `delta.side-by-side` | `true` | Side-by-side diff layout |
| `delta.line-numbers` | `true` | Line numbers in diff output |
| `delta.wrap-max-lines` | `unlimited` | No line truncation |
| `merge.conflictstyle` | `zdiff3` | Three-way merge conflicts with cleaner format (Git 2.35+) |
| `diff.colorMoved` | `default` | Color-codes moved lines in diffs |
| `include.path` | `~/.gitconfig.local` | Machine-local overrides (identity, credentials) |

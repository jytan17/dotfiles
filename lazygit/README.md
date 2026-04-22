# Lazygit

Terminal UI for git. Configured with delta pager and Zed as external editor.

## Setup

```sh
stow lazygit
```

## Dependencies / External Setup

- [lazygit](https://github.com/jesseduffield/lazygit) -- `brew install lazygit`
- [delta](https://github.com/dandavtimer/delta) -- diff pager (`brew install git-delta`)
- [Zed](https://zed.dev/) -- external editor

## File Structure

| File | Purpose |
|------|---------|
| `.config/lazygit/config.yml` | Main lazygit configuration |

## Notable Settings

| Setting | Value | Notes |
|---------|-------|-------|
| Nerd Fonts | v3 | Icons for branches, files, etc. |
| File view | Tree | Directory hierarchy instead of flat list |
| Random tips | Disabled | |
| Auto fetch | Enabled | Keeps remote state up-to-date |
| Main branches | `main`, `master` | Both recognized as trunk |
| Pager | `delta --dark --paging=never` | Syntax-highlighted diffs |
| Editor | `zed {{filename}}` | Opens files in Zed |
| Editor (at line) | `zed {{filename}}:{{line}}` | Opens at specific line in Zed |

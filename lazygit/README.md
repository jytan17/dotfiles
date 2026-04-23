# Lazygit

Terminal UI for git. Configured with delta pager and Neovim as external editor.

## Setup

```sh
stow lazygit
```

## Dependencies / External Setup

- [lazygit](https://github.com/jesseduffield/lazygit) -- `brew install lazygit`
- [delta](https://github.com/dandavtimer/delta) -- diff pager (`brew install git-delta`)
- [Neovim](https://neovim.io/) -- external editor (`brew install neovim`)

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
| Editor | `nvim {{filename}}` | Opens files in Neovim |
| Editor (at line) | `nvim +{{line}} {{filename}}` | Opens at specific line in Neovim |

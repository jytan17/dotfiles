# Neovim

Modal text editor configured with kickstart.nvim as a base. Designed to replicate the Zed editor experience with Vim keybindings.

## Setup

```sh
stow nvim
```

On first launch, lazy.nvim will auto-install all plugins. Mason will then install LSP servers. Run `:checkhealth` to verify everything is working.

## Dependencies / External Setup

- [Neovim](https://neovim.io/) >= 0.10 -- `brew install neovim`
- [ripgrep](https://github.com/BurntSushi/ripgrep) -- required by Telescope live grep (`brew install ripgrep`)
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) -- for icons
- C compiler (gcc/clang) -- for telescope-fzf-native and treesitter parsers

## File Structure

| File | Purpose |
|------|---------|
| `.config/nvim/init.lua` | Single-file config (kickstart.nvim based) |

## Key Bindings

Leader is `Space`.

### Find (Space f)

| Keys | Action |
|------|--------|
| `Space f f` | Find files |
| `Space f w` | Find word (live grep) |
| `Space f b` | Find buffers |
| `Space f h` | Find help |
| `Space f k` | Find keymaps |
| `Space f d` | Find diagnostics |
| `Space f r` | Resume last search |
| `Space f .` | Find recent files |
| `Space f c` | Find word under cursor |
| `Space f n` | Find neovim config files |
| `Space /` | Fuzzy search in current buffer |
| `Space Space` | Find existing buffers |

### LSP (Space l / gr)

| Keys | Action |
|------|--------|
| `Space l a` | Code action |
| `Space l r` | Rename symbol |
| `Space l f` | Format buffer |
| `Space l h` | Signature help |
| `Space l s` | Document symbols |
| `Space l S` | Workspace symbols |
| `grd` | Go to definition |
| `grr` | Go to references |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `grn` | Rename |
| `gra` | Code action |
| `grD` | Go to declaration |

### Git (Space g)

| Keys | Action |
|------|--------|
| `Space g b` | Blame line |
| `Space g d` | Toggle deleted |
| `Space g p` | Preview hunk |
| `Space g s` | Stage hunk |
| `Space g r` | Reset hunk |
| `Space g S` | Stage buffer |
| `Space g R` | Reset buffer |
| `]h` / `[h` | Next / previous hunk |

### Buffer (Space b)

| Keys | Action |
|------|--------|
| `Space b c` | Close buffer |
| `Space b C` | Close other buffers |

### Split (Space s)

| Keys | Action |
|------|--------|
| `Space s v` | Vertical split |
| `Space s h` | Horizontal split |

### Navigation

| Keys | Action |
|------|--------|
| `Ctrl-h/j/k/l` | Navigate splits (zellij/tmux-aware via smart-splits) |
| `Alt-h/j/k/l` | Resize splits (zellij/tmux-aware via smart-splits) |
| `]d` / `[d` | Next / previous diagnostic |

### Quick Actions

| Keys | Action |
|------|--------|
| `Space w` | Save file |
| `Space /` | Toggle comment |
| `Space q` | Diagnostic quickfix list |
| `Space t h` | Toggle inlay hints |
| `Space e` | Toggle file explorer |
| `Space o` | Focus file explorer |

## Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| catppuccin | Color theme |
| nvim-lspconfig | LSP configuration |
| mason.nvim | LSP/tool auto-installer |
| conform.nvim | Format on save |
| blink.cmp | Autocompletion |
| telescope.nvim | Fuzzy finder |
| neo-tree.nvim | File explorer |
| gitsigns.nvim | Git signs, blame, hunk actions |
| nvim-treesitter | Syntax highlighting |
| which-key.nvim | Keymap hints |
| mini.nvim | Surround, AI textobjects, statusline |
| smart-splits.nvim | Seamless zellij/tmux/nvim pane navigation + resize |
| todo-comments.nvim | Highlight TODO/FIXME/etc |
| guess-indent.nvim | Auto-detect indentation |
| fidget.nvim | LSP progress indicator |
| LuaSnip | Snippet engine |

## Notable Settings

- **Relative line numbers** enabled
- **Format on save** for Lua (stylua) and Python (ruff)
- **Autocompletion** with Tab/Shift-Tab to cycle, Ctrl-y to accept
- **Auto-show documentation** in completion menu (250ms delay)
- **Signature help** enabled
- **Inline diagnostics** (virtual text)
- **Clipboard sync** with system clipboard
- **Undo persistence** across sessions

### LSP Servers (auto-installed via Mason)

| Server | Language |
|--------|----------|
| basedpyright | Python (type checking, standard mode) |
| ruff | Python (linting, formatting) |
| lua_ls | Lua |

## Theme / Appearance

- **Theme:** Catppuccin Mocha (no italics)
- **Statusline:** mini.statusline with Nerd Font icons
- **File explorer:** neo-tree (35 columns, shows hidden files)
- **Cursor line** highlighted
- **Scroll offset** of 10 lines

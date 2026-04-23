# Neovim

Modal text editor configured to mirror Zed's vim-mode keybindings and IDE behavior. Uses mini.nvim as the backbone for most features.

## Setup

```sh
stow nvim
```

On first launch, lazy.nvim will auto-install all plugins and treesitter parsers. Run `:checkhealth` to verify.

## Dependencies / External Setup

- [Neovim](https://neovim.io/) >= 0.12 -- `brew install neovim`
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) (Medium weight) -- for icons and ligatures
- [Zellij](https://zellij.dev/) -- terminal multiplexer (for `<C-h/j/k/l>` pane navigation)
- [ripgrep](https://github.com/BurntSushi/ripgrep) -- required for snacks.nvim grep picker
- [fd](https://github.com/sharkdp/fd) -- recommended for fast file finding (falls back to ripgrep)
- LSP servers are auto-installed via Mason on first launch

## File Structure

| File | Purpose |
|------|---------|
| `.config/nvim/init.lua` | Options, folding, Python indent config, keymaps, lazy.nvim bootstrap |
| `.config/nvim/lua/plugins/mini.lua` | mini.nvim modules: surround, comment, ai, diff, indentscope, notify, starter, icons |
| `.config/nvim/lua/plugins/snacks.lua` | Fuzzy picker + smooth scrolling via snacks.nvim |
| `.config/nvim/lua/plugins/which-key.lua` | Keybind hint popup (shows after 500ms delay) |
| `.config/nvim/lua/plugins/neo-tree.lua` | Side-panel file explorer (Zed-style project panel, split open, copy path) |
| `.config/nvim/lua/plugins/flash.lua` | Flash jump navigation (type chars, labels appear, teleport) |
| `.config/nvim/lua/plugins/multicursor.lua` | Multiple cursors (Zed-matching gl, gL, ga, g>, g<) |
| `.config/nvim/lua/plugins/treesitter.lua` | Treesitter: highlight, indent, incremental selection, textobject move/swap |
| `.config/nvim/lua/plugins/lsp.lua` | LSP servers, Mason, diagnostics, LSP keybindings |
| `.config/nvim/lua/plugins/blink.lua` | Autocompletion (ghost text, auto-docs, mini.icons) |
| `.config/nvim/lua/plugins/conform.lua` | Format on save (ruff, rustfmt, stylua, etc.) |
| `.config/nvim/lua/plugins/autopairs.lua` | Auto-close brackets/quotes, smart Enter between pairs |
| `.config/nvim/lua/plugins/noice.lua` | Modern UI for cmdline, messages, notifications |
| `.config/nvim/lua/plugins/eagle.lua` | Combined hover: diagnostics + LSP info in one float (`K`) |
| `.config/nvim/lua/plugins/ufo.lua` | Enhanced folding with treesitter + line count display |
| `.config/nvim/lua/plugins/catppuccin.lua` | Catppuccin Mocha colorscheme |
| `.config/nvim/lua/plugins/lualine.lua` | Statusline (bubbles style) |
| `.config/nvim/lua/plugins/indent-blankline.lua` | Indent guide lines |
| `.config/nvim/lua/plugins/zellij-nav.lua` | Seamless Neovim/Zellij pane navigation |
| `.config/nvim/lua/plugins/markdown-preview.lua` | Browser-based markdown preview |

## Key Bindings

Leader key: `Space`

### Navigation

| Keys | Action |
|------|--------|
| `<C-h/j/k/l>` | Navigate splits / Zellij panes |
| `gd` | Go to definition (with preview picker) |
| `gD` | Go to declaration |
| `gy` | Go to type definition |
| `gI` | Go to implementation |
| `gA` | Go to references (with preview picker) |
| `gh` | LSP hover |
| `K` | Combined hover (diagnostics + LSP), press again to enter float |
| `gw` | Flash jump — type chars, labels appear, press to teleport |
| `f`/`t`/`F`/`T` | Enhanced with flash labels on multiple matches |
| `/` | Search with flash labels (press `<C-s>` to toggle) |
| `]m` / `[m` | Next/prev function |
| `]]` / `[[` | Next/prev class |
| `]a` / `[a` | Next/prev argument |
| `]/` / `[/` | Next/prev comment |
| `]d` / `[d` | Next/prev diagnostic |
| `]c` / `[c` | Next/prev git hunk |
| `]x` / `[x` | Select larger/smaller syntax node |

### Find (Snacks Picker)

| Keys | Action |
|------|--------|
| `<leader>ff` | Find files |
| `<leader>fw` / `g/` | Find word (live grep) / project search |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help |
| `<leader>fd` | Find diagnostics |
| `<leader>fr` | Resume last picker |
| `<leader>f/` | Find in current buffer |
| `<leader>fo` | Find recent files |
| `<leader>fk` | Find keymaps |

### LSP

| Keys | Action |
|------|--------|
| `<leader>la` / `g.` | Code actions |
| `<leader>lr` / `cd` | Rename symbol |
| `<leader>ld` | Line diagnostics (float) |
| `<leader>lD` | Diagnostics list (location list) |
| `<leader>lf` | Format file |
| `<leader>lh` | Signature help |
| `<leader>ls` / `gs` | Document symbols |
| `<leader>lS` / `gS` | Workspace symbols |

### Text Objects

All work with `d`, `c`, `y`, `v` — e.g. `daq` deletes around quote, `cif` changes inside function.

| Object | Inside / Around | Source |
|--------|----------------|--------|
| `q` | Any quote (`'` `"` `` ` ``) | mini.ai |
| `b` | Any bracket (`()` `[]` `{}`) | mini.ai |
| `a` | Argument (comma-separated) | mini.ai |
| `f` | Function | treesitter |
| `c` | Class | treesitter |
| `o` | Loop | treesitter |
| `e` | Conditional (if/else) | treesitter |
| `g` | Comment | treesitter |

Surround: `sa` (add), `sd` (delete), `sr` (replace), `S` (add in visual mode).

Swap arguments: `<leader>a` (next), `<leader>A` (previous).

### Folding

| Keys | Action |
|------|--------|
| `za` | Toggle fold |
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zK` | Peek inside fold |

### File Explorer (Neo-tree)

| Keys | Action |
|------|--------|
| `<leader>e` | Toggle side panel (reveals current file) |
| `<leader>o` | Toggle side panel (project root) |
| `l` / `h` | Open / collapse node |
| `s` | Open in horizontal split |
| `v` | Open in vertical split |
| `yp` | Copy relative path |
| `yP` | Copy absolute path |

### Git

| Keys | Action |
|------|--------|
| `<leader>gs` | Git status (picker) |
| `<leader>gl` | Git log (picker) |
| `<leader>gd` | Toggle diff overlay |
| `<leader>gb` | Git blame |
| `do` | Expand diff hunk (overlay) |
| `dp` | Revert hunk |

### General

| Keys | Action |
|------|--------|
| `<leader>w` | Save file |
| `<leader>q` | Close buffer |
| `<leader>/` | Toggle comment |
| `gcc` | Toggle comment (line) |
| `<leader>sv` / `<leader>sh` | Split vertical/horizontal |
| `<C-Space>` | Expand selection (treesitter) |
| `<BS>` | Shrink selection (treesitter) |
| `<C-.>` | Toggle zoom (maximize pane) |
| `<M-e>` | Fast wrap (surround next word with pair) |

### Multicursor

| Keys | Action |
|------|--------|
| `gl` | Add cursor at next match of word/selection |
| `gL` | Add cursor at ALL matches |
| `ga` | Add cursor operator (e.g. `gaip` = each line in paragraph) |
| `g>` / `g<` | Add cursor below / above |
| `gS` | Skip current match, jump to next |
| `gA` (visual) | Add cursor at end of each line in selection |
| `gI` (visual) | Add cursor at start of each line in selection |
| `gV` | Restore cleared cursors |
| `Esc` | Clear all cursors (only when multicursors active) |
| `Ctrl+click` | Add cursor with mouse |

When multicursors are active: `<left>`/`<right>` to cycle, `<leader>x` to delete one, `S` in visual to split by regex, `M` to match.

### Markdown

| Keys | Action |
|------|--------|
| `<leader>mp` | Toggle markdown preview (opens in browser) |

## Plugins

| Plugin | Purpose |
|--------|---------|
| mini.nvim | Surround, comment, ai text objects, diff, indentscope, notify, starter, icons |
| snacks.nvim | Fuzzy picker, smooth scrolling, zoom |
| which-key.nvim | Keybind hints popup (500ms delay, rounded border) |
| neo-tree.nvim | Side-panel file explorer |
| flash.nvim | Jump navigation with labels |
| multicursor.nvim | Multiple cursors (Zed-matching keybindings) |
| nvim-treesitter | Syntax highlighting, indent, incremental selection, textobject motions |
| nvim-lspconfig + Mason | LSP client + auto-install servers |
| blink.cmp | Autocompletion with ghost text |
| conform.nvim | Format on save |
| nvim-autopairs | Auto-close pairs, smart Enter between brackets |
| noice.nvim | Modern cmdline, messages, notifications |
| eagle.nvim | Combined diagnostics + hover float |
| nvim-ufo | Enhanced folding with line count display |
| catppuccin | Mocha colorscheme |
| lualine.nvim | Statusline (bubbles style) |
| indent-blankline.nvim | Indent guide lines |
| zellij-nav.nvim | Neovim/Zellij pane navigation |
| markdown-preview.nvim | Browser-based markdown preview (`<leader>mp`) |

## LSP Servers

| Server | Language | Notes |
|--------|----------|-------|
| basedpyright | Python | Standard type checking mode |
| ruff | Python | Linting/formatting only, hover disabled, matches Zed config (E/F/I rules, 120 line length) |
| rust_analyzer | Rust | Uses clippy for checks |
| lua_ls | Lua | Configured for Neovim runtime |
| marksman | Markdown | |
| dockerls | Dockerfile | |
| docker_compose_language_service | Docker Compose | |
| taplo | TOML | |
| jsonls | JSON | |
| yamlls | YAML | Schema store enabled |

## Notable Settings

- **Leader:** Space
- **Relative line numbers** enabled
- **Clipboard sync** with system clipboard
- **Undo persistence** across sessions
- **Smart case** search
- **Cursor line** highlighted, scroll offset of 10
- **Format on save** via conform (500ms timeout)
- **Diagnostics:** virtual text with `●` prefix, undercurl underlines
- **Signature help** disabled everywhere (too intrusive)
- **LSP progress notifications** disabled (basedpyright spam)
- **Zed vim-mode aliases** are available alongside leader keymaps: `g.` (code actions), `cd` (rename), `gs`/`gS` (symbols), `g/` (project search), `]d`/`[d` (diagnostics), `]c`/`[c` (git hunks), `do`/`dp` (diff hunk), `S` (visual surround), `]x`/`[x` (syntax node selection)

## Quirks

- **Python indent uses built-in indenter**, not treesitter. Treesitter indent for Python uses alignment-style indentation (aligns with first argument after `(`). The built-in `python#GetIndent` with `g:python_indent` settings gives IDE-style hanging indent instead. All other languages use treesitter indent.
- **Treesitter indentexpr requires a custom autocmd.** The new `nvim-treesitter` API (Neovim 0.12+) doesn't auto-set `indentexpr` on buffers like the old `nvim-treesitter.configs` did. A `FileType` autocmd in `treesitter.lua` handles this.
- **nvim-ufo manages folding.** Don't set `foldmethod` or `foldexpr` manually — ufo overrides them to `manual` at runtime.
- **Eagle.nvim `K` cycle:** press once to open float, again to enter it, again to close. `q`/`Esc` don't dismiss eagle floats.
- **Zellij integration:** `<C-h/j/k/l>` uses Zellij's locked mode. A `VimLeave` autocmd unlocks Zellij when exiting Neovim. Requires `zellij-autolock` plugin in the Zellij layout.
- **LSP goto uses snacks picker.** `gd`, `gA`, `gI`, `gy` open a picker with preview instead of jumping directly. If there's only one result it jumps immediately.

## Theme / Appearance

- **Colorscheme:** Catppuccin Mocha
- **Font:** JetBrainsMono Nerd Font, Medium weight
- **Statusline:** Lualine with bubble-style rounded separators
- **Diagnostics:** Nerd Font signs in gutter, undercurl underlines (requires terminal undercurl support)
- **Fold column:** 1-character wide gutter indicator
- **Indent guides:** indent-blankline for all levels, mini.indentscope for active scope animation
- **File explorer:** Neo-tree left panel (35 chars wide), git status icons, follows current file

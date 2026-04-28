-- ─────────────────────────────────────────────────────────────────
-- nvim-treesitter v1.x (main branch / "new API")
-- ─────────────────────────────────────────────────────────────────
-- IMPORTANT for future agents:
-- This config targets the **main** branch of nvim-treesitter (v1.0+),
-- NOT the legacy `master` branch. The two APIs are incompatible.
--
-- Key differences from old API (master):
--   • setup({ ensure_installed, highlight, indent, textobjects,
--     incremental_selection }) is GONE. Those keys are silently ignored.
--   • Parsers installed via `require('nvim-treesitter').install({...})`.
--   • Highlight = `vim.treesitter.start()` per buffer (FileType autocmd).
--   • Indent = `v:lua.require'nvim-treesitter'.indentexpr()` (per buffer).
--   • Textobjects = nvim-treesitter-textobjects with its own setup().
--   • Incremental selection module REMOVED. Roll your own using
--     `vim.treesitter.get_node()` + parent traversal (below).
--
-- If lazy-lock pins to `branch = "master"`, this file won't work; revert
-- to old-API config in git history.
-- ─────────────────────────────────────────────────────────────────

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    -- ── Parsers ─────────────────────────────────────────────
    -- install() is idempotent: skips parsers already on disk.
    require('nvim-treesitter').install({
      -- Languages I use
      'python', 'rust', 'markdown', 'markdown_inline', 'dockerfile',
      'toml', 'json', 'yaml', 'just',
      -- Always useful
      'lua', 'luadoc', 'vim', 'vimdoc', 'bash', 'fish',
      'html', 'css', 'regex', 'diff', 'gitcommit', 'git_rebase',
    })

    -- ── Highlight + indent on FileType ──────────────────────
    -- Built-in indenters win for these (TS queries weak/wrong):
    --   • python → g:python_indent (init.lua, hanging style)
    --   • rust   → GetRustIndent() (paren/brace correctness)
    local ts_indent_exclude = { python = true, rust = true }

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-attach', { clear = true }),
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == '' or ft == 'snacks_dashboard' then return end
        local ok = pcall(vim.treesitter.start, args.buf, ft)
        if not ok then return end
        if not ts_indent_exclude[ft] then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    -- ── Textobjects: move + swap (selection handled by mini.ai) ──
    require('nvim-treesitter-textobjects').setup({
      select = { enable = false },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
          [']a'] = '@parameter.inner',
          [']/'] = '@comment.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
          ['[a'] = '@parameter.inner',
          ['[/'] = '@comment.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = { ['<leader>a'] = '@parameter.inner' },
        swap_previous = { ['<leader>A'] = '@parameter.inner' },
      },
    })

    -- ── Incremental selection (rolled by hand; module removed in v1) ──
    local sel_history = {}

    local function set_visual(srow, scol, erow, ecol)
      vim.fn.setpos("'<", { 0, srow + 1, scol + 1, 0 })
      vim.fn.setpos("'>", { 0, erow + 1, math.max(1, ecol), 0 })
      vim.cmd('normal! gv')
    end

    local function init_selection()
      sel_history = {}
      local ok, node = pcall(vim.treesitter.get_node)
      if not ok or not node then return end
      table.insert(sel_history, node)
      set_visual(node:range())
    end

    local function node_incremental()
      if #sel_history == 0 then init_selection() return end
      local parent = sel_history[#sel_history]:parent()
      if not parent then return end
      table.insert(sel_history, parent)
      set_visual(parent:range())
    end

    local function node_decremental()
      if #sel_history <= 1 then return end
      table.remove(sel_history)
      local node = sel_history[#sel_history]
      set_visual(node:range())
    end

    vim.keymap.set('n', '<C-space>', init_selection, { desc = 'Init node selection' })
    vim.keymap.set('x', '<C-space>', node_incremental, { desc = 'Expand node' })
    vim.keymap.set('x', '<BS>', node_decremental, { desc = 'Shrink node' })

    -- Zed vim-mode aliases: ]x/[x for syntax node expand/shrink
    vim.keymap.set('n', ']x', init_selection, { desc = 'Select syntax node' })
    vim.keymap.set('x', ']x', node_incremental, { desc = 'Expand syntax node' })
    vim.keymap.set('x', '[x', node_decremental, { desc = 'Shrink syntax node' })

    -- ── Leader bracket aliases (next/prev function/class/comment) ──
    vim.keymap.set('n', '<leader>nf', ']m', { remap = true, desc = 'Next function' })
    vim.keymap.set('n', '<leader>pf', '[m', { remap = true, desc = 'Prev function' })
    vim.keymap.set('n', '<leader>nc', ']]', { remap = true, desc = 'Next class' })
    vim.keymap.set('n', '<leader>pc', '[[', { remap = true, desc = 'Prev class' })
    vim.keymap.set('n', '<leader>n/', ']/', { remap = true, desc = 'Next comment' })
    vim.keymap.set('n', '<leader>p/', '[/', { remap = true, desc = 'Prev comment' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

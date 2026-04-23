return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  lazy = false,
  opts = {
    ensure_installed = {
      -- Languages you use
      'python',
      'rust',
      'markdown',
      'markdown_inline',
      'dockerfile',
      'toml',
      'json',
      'jsonc',
      'yaml',

      -- Always useful
      'lua',
      'luadoc',
      'vim',
      'vimdoc',
      'bash',
      'fish',
      'html',
      'css',
      'regex',
      'diff',
      'gitcommit',
      'git_rebase',
    },

    highlight = {
      enable = true,
      disable = { 'snacks_dashboard' },
    },
    indent = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<BS>',
      },
    },

    textobjects = {
      -- Selection is handled by mini.ai with treesitter specs (see mini.lua)
      -- Only move and swap are configured here
      select = { enable = false },

      move = {
        enable = true,
        set_jumps = true, -- Add to jumplist
        goto_next_start = {
          [']m'] = { query = '@function.outer', desc = 'Next function start' },
          [']]'] = { query = '@class.outer', desc = 'Next class start' },
          [']a'] = { query = '@parameter.inner', desc = 'Next argument' },
          [']/'] = { query = '@comment.outer', desc = 'Next comment' },
        },
        goto_next_end = {
          [']M'] = { query = '@function.outer', desc = 'Next function end' },
          [']['] = { query = '@class.outer', desc = 'Next class end' },
        },
        goto_previous_start = {
          ['[m'] = { query = '@function.outer', desc = 'Prev function start' },
          ['[['] = { query = '@class.outer', desc = 'Prev class start' },
          ['[a'] = { query = '@parameter.inner', desc = 'Prev argument' },
          ['[/'] = { query = '@comment.outer', desc = 'Prev comment' },
        },
        goto_previous_end = {
          ['[M'] = { query = '@function.outer', desc = 'Prev function end' },
          ['[]'] = { query = '@class.outer', desc = 'Prev class end' },
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = { query = '@parameter.inner', desc = 'Swap with next argument' },
        },
        swap_previous = {
          ['<leader>A'] = { query = '@parameter.inner', desc = 'Swap with prev argument' },
        },
      },
    },
  },
  main = 'nvim-treesitter',
  config = function(_, opts)
    require('nvim-treesitter').setup(opts)

    -- The new nvim-treesitter API doesn't auto-set indentexpr for buffers.
    -- Apply treesitter indent for all languages EXCEPT Python (which uses
    -- its own built-in indenter configured via g:python_indent in init.lua).
    local ts_indent_exclude = { python = true }

    local function apply_ts_indent()
      local ft = vim.bo.filetype
      if ft == '' or ts_indent_exclude[ft] then return end
      local ok = pcall(vim.treesitter.get_parser, 0, ft)
      if ok then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-indent', { clear = true }),
      callback = function()
        vim.defer_fn(apply_ts_indent, 10)
      end,
    })
    apply_ts_indent()

    -- Wire up leader next/prev keymaps that were deferred from mini.lua
    vim.keymap.set('n', '<leader>nf', ']m', { remap = true, desc = 'Next function' })
    vim.keymap.set('n', '<leader>pf', '[m', { remap = true, desc = 'Prev function' })
    vim.keymap.set('n', '<leader>nc', ']]', { remap = true, desc = 'Next class' })
    vim.keymap.set('n', '<leader>pc', '[[', { remap = true, desc = 'Prev class' })
    vim.keymap.set('n', '<leader>n/', ']/', { remap = true, desc = 'Next comment' })
    vim.keymap.set('n', '<leader>p/', '[/', { remap = true, desc = 'Prev comment' })

    -- Zed vim-mode aliases: [x/]x for syntax node selection (expand/shrink)
    vim.keymap.set({ 'n', 'x' }, ']x', function()
      if vim.fn.mode() == 'n' then
        vim.cmd('normal! v')
      end
      require('nvim-treesitter.incremental_selection').node_incremental()
    end, { desc = 'Select larger syntax node' })
    vim.keymap.set('x', '[x', function()
      require('nvim-treesitter.incremental_selection').node_decremental()
    end, { desc = 'Select smaller syntax node' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

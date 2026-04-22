return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  event = 'BufReadPost',
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

    highlight = { enable = true },
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
      select = {
        enable = true,
        lookahead = true, -- Jump forward to matching textobject
        keymaps = {
          -- Function (matches Zed: af/if)
          ['af'] = { query = '@function.outer', desc = 'Around function' },
          ['if'] = { query = '@function.inner', desc = 'Inside function' },
          -- Class (matches Zed: ac/ic)
          ['ac'] = { query = '@class.outer', desc = 'Around class' },
          ['ic'] = { query = '@class.inner', desc = 'Inside class' },
          -- Argument (matches Zed: aa/ia)
          ['aa'] = { query = '@parameter.outer', desc = 'Around argument' },
          ['ia'] = { query = '@parameter.inner', desc = 'Inside argument' },
          -- Conditional
          ['ai'] = { query = '@conditional.outer', desc = 'Around conditional' },
          ['ii'] = { query = '@conditional.inner', desc = 'Inside conditional' },
          -- Loop
          ['al'] = { query = '@loop.outer', desc = 'Around loop' },
          ['il'] = { query = '@loop.inner', desc = 'Inside loop' },
          -- Comment (matches Zed: gc)
          ['gc'] = { query = '@comment.outer', desc = 'Comment' },
        },
      },

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

    -- Wire up leader next/prev keymaps that were deferred from mini.lua
    vim.keymap.set('n', '<leader>nf', ']m', { remap = true, desc = 'Next function' })
    vim.keymap.set('n', '<leader>pf', '[m', { remap = true, desc = 'Prev function' })
    vim.keymap.set('n', '<leader>nc', ']]', { remap = true, desc = 'Next class' })
    vim.keymap.set('n', '<leader>pc', '[[', { remap = true, desc = 'Prev class' })
    vim.keymap.set('n', '<leader>n/', ']/', { remap = true, desc = 'Next comment' })
    vim.keymap.set('n', '<leader>p/', '[/', { remap = true, desc = 'Prev comment' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

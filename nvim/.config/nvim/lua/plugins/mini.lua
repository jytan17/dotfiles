return {
  'echasnovski/mini.nvim',
  version = false, -- Use latest
  config = function()
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Icons (must be set up before other mini modules)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Text editing modules
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    -- Surround: sa (add), sd (delete), sr (replace)
    require('mini.surround').setup()

    -- Zed vim-mode alias: Shift-S in visual mode adds surround
    vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { desc = 'Add surround', silent = true })

    -- Comment: gcc (line), gc (visual)
    require('mini.comment').setup()

    -- AI: enhanced text objects (Zed-matching: q=quote, b=bracket, f=function, etc.)
    local ai = require('mini.ai')
    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        -- q = any quote (' " `)
        q = { { "%b''", '%b""', '%b``' }, '^.().*().$' },
        -- b = any bracket (parens, braces, square)
        b = { { '%b()', '%b[]', '%b{}' }, '^.().*().$' },
        -- a = argument (comma-separated, handles delimiters properly for daa/dia)
        a = ai.gen_spec.argument({ separator = '[,;]' }),
        -- Treesitter-powered
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
        o = ai.gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
        e = ai.gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
        g = ai.gen_spec.treesitter({ a = '@comment.outer', i = '@comment.inner' }),
      },
    })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Git diff (sign column indicators)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    require('mini.diff').setup({
      view = {
        style = 'sign',
        signs = { add = '▎', change = '▎', delete = '▁' },
      },
    })

    vim.keymap.set('n', '<leader>gd', function()
      MiniDiff.toggle_overlay(0)
    end, { desc = 'Toggle diff overlay' })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Indent scope (animated indent guide)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    require('mini.indentscope').setup({
      symbol = '│',
      options = { try_as_border = true },
    })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Notify (notification system)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    require('mini.notify').setup({
      lsp_progress = { enable = false },
    })
    vim.notify = MiniNotify.make_notify()

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Zed-matching keymaps (non-plugin-specific)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    -- Quick actions
    vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
    vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = 'Close buffer' })
    vim.keymap.set({ 'n', 'x' }, '<leader>/', function()
      return MiniComment.operator() .. '_'
    end, { expr = true, desc = 'Toggle comment' })

    -- Buffer management
    vim.keymap.set('n', '<leader>bc', '<cmd>bd<CR>', { desc = 'Close buffer' })
    vim.keymap.set('n', '<leader>bC', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close other buffers' })

    -- Splits (matching Zed: space s …)
    vim.keymap.set('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Split right' })
    vim.keymap.set('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Split down' })

    -- Terminal (matching Zed: space t …)
    vim.keymap.set('n', '<leader>tf', '<cmd>terminal<CR>', { desc = 'Open terminal' })
    vim.keymap.set('n', '<leader>tt', '<cmd>terminal<CR>', { desc = 'New terminal' })

    -- Git blame (shell out to git, will improve if adding a git plugin later)
    vim.keymap.set('n', '<leader>gb', function()
      local line = vim.fn.line('.')
      local file = vim.fn.expand('%')
      vim.cmd('terminal git blame -L ' .. line .. ',+5 ' .. file)
    end, { desc = 'Git blame' })

    -- Next/Previous navigation
    vim.keymap.set('n', '<leader>nd', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
    vim.keymap.set('n', '<leader>pd', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
    vim.keymap.set('n', '<leader>nh', function() MiniDiff.goto_hunk('next') end, { desc = 'Next git hunk' })
    vim.keymap.set('n', '<leader>ph', function() MiniDiff.goto_hunk('prev') end, { desc = 'Prev git hunk' })
    vim.keymap.set('n', '<leader>np', '}', { desc = 'Next paragraph' })
    vim.keymap.set('n', '<leader>pp', '{', { desc = 'Prev paragraph' })

    -- Zed vim-mode bracket aliases: ]d/[d for diagnostics, ]c/[c for git hunks
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
    vim.keymap.set('n', ']c', function() MiniDiff.goto_hunk('next') end, { desc = 'Next git hunk' })
    vim.keymap.set('n', '[c', function() MiniDiff.goto_hunk('prev') end, { desc = 'Prev git hunk' })

    -- Zed vim-mode git diff operations: do (expand hunk), dp (revert hunk)
    vim.keymap.set('n', 'do', function() MiniDiff.toggle_overlay(0) end, { desc = 'Expand diff hunk' })
    vim.keymap.set('n', 'dp', function() MiniDiff.operator('reset') end, { desc = 'Revert hunk' })

    -- Note: next/prev function, class, comment will be added with treesitter-textobjects
  end,
}
-- vim: ts=2 sts=2 sw=2 et

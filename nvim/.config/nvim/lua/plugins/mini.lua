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
    -- Pick (fuzzy finder) — replaces telescope
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    require('mini.pick').setup({
      mappings = {
        move_down = '<C-j>',
        move_up = '<C-k>',
      },
    })
    require('mini.extra').setup()

    -- Find keymaps (matching Zed: space f …)
    vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fw', '<cmd>Pick grep_live<CR>', { desc = 'Find word (grep)' })
    vim.keymap.set('n', '<leader>fb', '<cmd>Pick buffers<CR>', { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<CR>', { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic scope="all"<CR>', { desc = 'Find diagnostics' })
    vim.keymap.set('n', '<leader>fr', '<cmd>Pick resume<CR>', { desc = 'Find resume (last picker)' })
    vim.keymap.set('n', '<leader>f/', '<cmd>Pick buf_lines scope="current"<CR>', { desc = 'Find in current buffer' })
    vim.keymap.set('n', '<leader>ls', '<cmd>Pick buf_lines scope="current"<CR>', { desc = 'Document symbols' })
    vim.keymap.set('n', '<leader>lS', '<cmd>Pick lsp scope="workspace_symbol"<CR>', { desc = 'Workspace symbols' })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Clue (keybind hints) — replaces which-key
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    local miniclue = require('mini.clue')
    miniclue.setup({
      triggers = {
        -- Leader
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" },
        { mode = 'x', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },

        -- Window
        { mode = 'n', keys = '<C-w>' },

        -- Brackets
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },
        { mode = 'x', keys = '[' },
        { mode = 'x', keys = ']' },

        -- z key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),

        -- Leader group descriptions
        { mode = 'n', keys = '<Leader>f', desc = '+find' },
        { mode = 'n', keys = '<Leader>l', desc = '+lsp' },
        { mode = 'n', keys = '<Leader>g', desc = '+git' },
        { mode = 'n', keys = '<Leader>b', desc = '+buffer' },
        { mode = 'n', keys = '<Leader>s', desc = '+split' },
        { mode = 'n', keys = '<Leader>t', desc = '+terminal' },
        { mode = 'n', keys = '<Leader>n', desc = '+next' },
        { mode = 'n', keys = '<Leader>p', desc = '+prev' },
      },

      window = {
        delay = 300,
        config = { width = 'auto' },
      },
    })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Files (file explorer) — mini.files
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    require('mini.files').setup({
      mappings = {
        go_in = 'l',
        go_in_plus = 'L',
        go_out = 'h',
        go_out_plus = 'H',
      },
      windows = {
        preview = true,
        width_preview = 40,
      },
    })

    -- Toggle file explorer at current file (matching Zed: space e / space o)
    vim.keymap.set('n', '<leader>e', function()
      if not MiniFiles.close() then
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end
    end, { desc = 'Toggle file explorer' })

    vim.keymap.set('n', '<leader>o', function()
      if not MiniFiles.close() then
        MiniFiles.open()
      end
    end, { desc = 'Toggle file explorer (root)' })

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Text editing modules
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    -- Pairs: auto-close brackets, quotes
    require('mini.pairs').setup()

    -- Surround: sa (add), sd (delete), sr (replace)
    require('mini.surround').setup()

    -- Comment: gcc (line), gc (visual)
    require('mini.comment').setup()

    -- AI: enhanced text objects (function, class, argument, quotes, brackets)
    local ai = require('mini.ai')
    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        -- Any quote (matches Zed's MiniQuotes behavior)
        q = ai.gen_spec.argument({ brackets = { { "'", "'" }, { '"', '"' }, { '`', '`' } } }),
        -- Treesitter-based objects will be added when treesitter is configured
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
    require('mini.notify').setup()
    vim.notify = MiniNotify.make_notify()

    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- Starter (start screen)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    local starter = require('mini.starter')
    starter.setup({
      items = {
        starter.sections.recent_files(5, false),
        starter.sections.recent_files(5, true),
        starter.sections.builtin_actions(),
      },
      header = '',
      footer = '',
    })

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
    -- Note: next/prev function, class, comment will be added with treesitter-textobjects
  end,
}
-- vim: ts=2 sts=2 sw=2 et

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle reveal<CR>', desc = 'Toggle file explorer' },
    { '<leader>o', '<cmd>Neotree toggle<CR>', desc = 'Toggle file explorer (root)' },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    window = {
      position = 'left',
      width = 35,
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['s'] = 'open_split',
        ['v'] = 'open_vsplit',
        ['<space>'] = 'none', -- Don't conflict with leader
        ['yp'] = function(state)
          local node = state.tree:get_node()
          local relative = vim.fn.fnamemodify(node:get_id(), ':~:.')
          vim.fn.setreg('+', relative)
          vim.notify('Copied: ' .. relative)
        end,
        ['yP'] = function(state)
          local node = state.tree:get_node()
          local absolute = node:get_id()
          vim.fn.setreg('+', absolute)
          vim.notify('Copied: ' .. absolute)
        end,
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
      git_status = {
        symbols = {
          added = '',
          modified = '',
          deleted = '',
          renamed = '󰁕',
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

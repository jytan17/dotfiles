return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle reveal<CR>', desc = 'Toggle file explorer' },
    { '<leader>o', '<cmd>Neotree toggle<CR>', desc = 'Toggle file explorer (root)' },
  },
  opts = {
    close_if_last_window = true,
    sort_case_insensitive = true,
    sort_function = function(a, b)
      -- Natural sort: directories first, then numeric-aware comparison
      if a.type ~= b.type then
        return a.type < b.type
      end
      local a_name = a.path:match('[^/]+$') or a.path
      local b_name = b.path:match('[^/]+$') or b.path
      local a_parts, b_parts = {}, {}
      for part in a_name:lower():gmatch('(%d+)') do a_parts[#a_parts + 1] = tonumber(part) end
      for part in b_name:lower():gmatch('(%d+)') do b_parts[#b_parts + 1] = tonumber(part) end
      -- Split into text and number segments for proper comparison
      local a_segs, b_segs = {}, {}
      for text, num in a_name:lower():gmatch('(%D*)(%d*)') do
        if text ~= '' then a_segs[#a_segs + 1] = text end
        if num ~= '' then a_segs[#a_segs + 1] = tonumber(num) end
      end
      for text, num in b_name:lower():gmatch('(%D*)(%d*)') do
        if text ~= '' then b_segs[#b_segs + 1] = text end
        if num ~= '' then b_segs[#b_segs + 1] = tonumber(num) end
      end
      for i = 1, math.max(#a_segs, #b_segs) do
        local sa, sb = a_segs[i], b_segs[i]
        if sa == nil then return true end
        if sb == nil then return false end
        if type(sa) ~= type(sb) then return type(sa) == 'number' end
        if sa ~= sb then return sa < sb end
      end
      return false
    end,
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
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
        ['<Right>'] = 'open',
        ['<Left>'] = 'close_node',
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
    enable_diagnostics = true,
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
      diagnostics = {
        symbols = {
          error = '\u{ea87} ',
          warn = '\u{ea6c} ',
          info = '\u{ea74} ',
          hint = '\u{f0336} ',
        },
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

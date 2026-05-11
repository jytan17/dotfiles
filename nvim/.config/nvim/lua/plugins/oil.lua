return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  keys = {
    { '<leader>e', function() require('oil').toggle_float() end, desc = 'Open file explorer (parent dir)' },
    { '<leader>o', function() require('oil').toggle_float(vim.fn.getcwd()) end, desc = 'Open file explorer (project root)' },
    { '-', function() require('oil').toggle_float() end, desc = 'Open parent directory' },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    columns = {
      'icon',
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name)
        return name == '..' or name == '.git'
      end,
    },
    keymaps = {
      ['g?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['l'] = 'actions.select',
      ['h'] = 'actions.parent',
      ['-'] = 'actions.parent',
      ['s'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open in horizontal split' },
      ['v'] = { 'actions.select', opts = { vertical = true }, desc = 'Open in vertical split' },
      ['<C-p>'] = 'actions.preview',
      ['q'] = 'actions.close',
      ['<Esc>'] = 'actions.close',
      ['R'] = 'actions.refresh',
      ['yp'] = {
        desc = 'Copy relative path',
        callback = function()
          local oil = require('oil')
          local entry = oil.get_cursor_entry()
          local dir = oil.get_current_dir()
          if not entry or not dir then return end
          local relpath = vim.fn.fnamemodify(dir .. entry.name, ':~:.')
          vim.fn.setreg('+', relpath)
          vim.notify('Copied: ' .. relpath)
        end,
      },
      ['yP'] = {
        desc = 'Copy absolute path',
        callback = function()
          local oil = require('oil')
          local entry = oil.get_cursor_entry()
          local dir = oil.get_current_dir()
          if not entry or not dir then return end
          local abspath = dir .. entry.name
          vim.fn.setreg('+', abspath)
          vim.notify('Copied: ' .. abspath)
        end,
      },
    },
    -- Disable default keymaps so we have full control
    use_default_keymaps = false,
    float = {
      padding = 4,
      max_width = 80,
      max_height = 30,
      border = 'rounded',
    },
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
  },
}
-- vim: ts=2 sts=2 sw=2 et

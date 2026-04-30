-- Bubble-style separators (half-circle glyphs from Nerd Font)
local left_bubble = '\238\130\182'   -- U+E0B6 (right half-circle, opens bubble)
local right_bubble = '\238\130\180'  -- U+E0B4 (left half-circle, closes bubble)

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'catppuccin/nvim' },
  opts = {
    options = {
      theme = 'catppuccin-mocha',
      component_separators = '',
      section_separators = { left = right_bubble, right = left_bubble },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = left_bubble }, right_padding = 2 },
      },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = {
        {
          function()
            local count = 0
            for _, b in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(b) and vim.bo[b].buflisted then count = count + 1 end
            end
            return '󰈔 ' .. count
          end,
        },
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'location', separator = { right = right_bubble }, left_padding = 2 },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

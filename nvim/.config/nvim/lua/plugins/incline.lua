return {
  'b0o/incline.nvim',
  event = 'VeryLazy',
  dependencies = { 'catppuccin/nvim' },
  opts = function()
    local colors = require('catppuccin.palettes').get_palette 'mocha'
    return {
      render = function(props)
        local buf = props.buf
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':t')
        if filename == '' then filename = '[No Name]' end

        local icon, icon_hl = require('mini.icons').get('file', filename)
        local icon_fg = icon_hl and vim.api.nvim_get_hl(0, { name = icon_hl }).fg

        local modified = vim.bo[buf].modified

        local result = {}
        if icon then
          table.insert(result, {
            icon .. ' ',
            guifg = icon_fg and string.format('#%06x', icon_fg) or colors.subtext0,
          })
        end
        table.insert(result, {
          filename,
          gui = modified and 'bold,italic' or nil,
        })
        if modified then
          table.insert(result, { ' ●', guifg = colors.peach })
        end

        return result
      end,
      window = {
        padding = { left = 1, right = 1 },
        margin = { horizontal = 0, vertical = 0 },
        placement = { horizontal = 'right', vertical = 'top' },
        winhighlight = {
          active = { Normal = 'InclineActive' },
          inactive = { Normal = 'InclineInactive' },
        },
      },
      hide = {
        cursorline = false,
        focused_win = false,
        only_win = false,
      },
    }
  end,
  config = function(_, opts)
    local colors = require('catppuccin.palettes').get_palette 'mocha'
    -- Active: slightly brighter surface with light text
    vim.api.nvim_set_hl(0, 'InclineActive', { bg = colors.surface1, fg = colors.text })
    -- Inactive: subtle surface with muted text
    vim.api.nvim_set_hl(0, 'InclineInactive', { bg = colors.surface0, fg = colors.overlay1 })
    require('incline').setup(opts)
  end,
}
-- vim: ts=2 sts=2 sw=2 et

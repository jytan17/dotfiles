return {
  'levouh/tint.nvim',
  event = 'VeryLazy',
  opts = function()
    return {
      tint = -45,
      saturation = 1.0,
      tint_background_colors = false,
      highlight_ignore_patterns = { 'WinSeparator', 'Status.*', 'LineNr', 'SignColumn', 'CursorLine', 'CursorLineNr' },
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufid })
        local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufid })
        if buftype == 'terminal' or buftype == 'prompt' then return true end
        if filetype == 'oil' or filetype == 'noice' or filetype == 'snacks_picker_list' then return true end
        return vim.api.nvim_win_get_config(winid).relative ~= ''
      end,
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et

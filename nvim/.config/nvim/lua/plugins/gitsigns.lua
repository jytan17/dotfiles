-- gitsigns: inline current-line blame (Zed-style) + popup blame
-- Sign column intentionally disabled — mini.diff handles hunk signs.
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signcolumn = false,
    numhl = false,
    linehl = false,
    word_diff = false,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 300,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '  <author>, <author_time:%R> · <summary>',
    preview_config = {
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = require('gitsigns')
      vim.keymap.set('n', '<leader>gb', function() gs.blame_line({ full = true }) end,
        { buffer = bufnr, desc = 'Git blame line (popup)' })
      vim.keymap.set('n', '<leader>gB', gs.toggle_current_line_blame,
        { buffer = bufnr, desc = 'Toggle inline blame' })
    end,
  },
}

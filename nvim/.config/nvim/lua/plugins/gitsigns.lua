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
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map('<leader>gb', function() gs.blame_line({ full = true }) end, 'Git blame line (popup)')
      map('<leader>gB', gs.toggle_current_line_blame, 'Toggle inline blame')
      map('<leader>ghp', gs.preview_hunk,    'Hunk: preview')
      map('<leader>ghs', gs.stage_hunk,      'Hunk: stage')
      map('<leader>ghr', gs.reset_hunk,      'Hunk: reset (restore)')
      map('<leader>ghu', gs.undo_stage_hunk, 'Hunk: undo stage')
      map('<leader>gS',  gs.stage_buffer,    'Stage entire buffer')
      map('<leader>gR',  gs.reset_buffer,    'Reset entire buffer')
    end,
  },
}

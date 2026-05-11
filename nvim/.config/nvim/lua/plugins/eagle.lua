return {
  'soulis-1256/eagle.nvim',
  config = function()
    local eagle_util = require('eagle.util')
    require('eagle').setup({
      keyboard_mode = true, -- Triggered via K keymap, not just mouse
      show_lsp_info = true, -- Show LSP hover alongside diagnostics
    })
    -- Required for mouse hover support
    vim.o.mousemoveevent = true
    -- Global K mapping so it works even before LSP attaches
    vim.keymap.set('n', 'K', '<cmd>EagleWin<CR>', { noremap = true, silent = true, desc = 'Hover / diagnostics' })
    -- Close eagle float with q or Esc when inside it
    vim.api.nvim_create_autocmd('WinEnter', {
      callback = function()
        local win = vim.api.nvim_get_current_win()
        if eagle_util.eagle_win and win == eagle_util.eagle_win then
          vim.keymap.set('n', 'q', '<cmd>EagleWin<CR>', { buffer = 0, silent = true })
          vim.keymap.set('n', '<Esc>', '<cmd>EagleWin<CR>', { buffer = 0, silent = true })
        end
      end,
    })
  end,
}

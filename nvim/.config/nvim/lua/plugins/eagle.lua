return {
  'soulis-1256/eagle.nvim',
  config = function()
    require('eagle').setup({
      keyboard_mode = true, -- Triggered via K keymap, not just mouse
      show_lsp_info = true, -- Show LSP hover alongside diagnostics
    })
    -- Required for mouse hover support
    vim.o.mousemoveevent = true
    -- Global K mapping so it works even before LSP attaches
    vim.keymap.set('n', 'K', '<cmd>EagleWin<CR>', { noremap = true, silent = true, desc = 'Hover / diagnostics' })
  end,
}

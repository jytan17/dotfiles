return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local hooks = require('ibl.hooks')
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'IblDimmed', { fg = '#45475a' }) -- catppuccin mocha surface1
    end)
    require('ibl').setup({
      indent = {
        char = '┊',
        highlight = 'IblDimmed',
      },
      scope = {
        enabled = false, -- mini.indentscope handles active scope highlight
      },
    })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Load before other plugins
  opts = {
    flavour = 'mocha',
    integrations = {
      mini = { enabled = true },
      native_lsp = { enabled = true },
      treesitter = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}
-- vim: ts=2 sts=2 sw=2 et

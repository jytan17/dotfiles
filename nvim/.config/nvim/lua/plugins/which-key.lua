return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 500,
    icons = {
      mappings = false,
      keys = {},
    },
    win = {
      border = 'rounded',
    },
    spec = {
      { '<leader>f', group = 'find' },
      { '<leader>l', group = 'lsp' },
      { '<leader>g', group = 'git' },
      { '<leader>b', group = 'buffer' },
      { '<leader>s', group = 'split' },
      { '<leader>t', group = 'terminal' },
      { '<leader>n', group = 'next' },
      { '<leader>p', group = 'prev' },
      { '<leader>u', group = 'toggle' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim', -- for mini.icons
  },
  opts = {
    completions = { lsp = { enabled = true } },
  },
  keys = {
    { '<leader>mp', '<cmd>RenderMarkdown toggle<CR>', desc = 'Toggle markdown render' },
  },
}
-- vim: ts=2 sts=2 sw=2 et

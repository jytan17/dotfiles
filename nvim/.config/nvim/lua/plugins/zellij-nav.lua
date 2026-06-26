return {
  'swaits/zellij-nav.nvim',
  lazy = true,
  event = 'VeryLazy',
  cond = function() return vim.env.ZELLIJ ~= nil end,
  keys = {
    { '<C-h>', '<cmd>ZellijNavigateLeft<CR>',  desc = 'Navigate left' },
    { '<C-j>', '<cmd>ZellijNavigateDown<CR>',  desc = 'Navigate down' },
    { '<C-k>', '<cmd>ZellijNavigateUp<CR>',    desc = 'Navigate up' },
    { '<C-l>', '<cmd>ZellijNavigateRight<CR>', desc = 'Navigate right' },
  },
  opts = {},
}
-- vim: ts=2 sts=2 sw=2 et

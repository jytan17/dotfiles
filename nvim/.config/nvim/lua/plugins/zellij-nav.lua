return {
  'swaits/zellij-nav.nvim',
  lazy = true,
  event = 'VeryLazy',
  keys = {
    { '<C-h>', '<cmd>ZellijNavigateLeftTab<CR>',  desc = 'Navigate left or tab' },
    { '<C-j>', '<cmd>ZellijNavigateDown<CR>',     desc = 'Navigate down' },
    { '<C-k>', '<cmd>ZellijNavigateUp<CR>',       desc = 'Navigate up' },
    { '<C-l>', '<cmd>ZellijNavigateRightTab<CR>', desc = 'Navigate right or tab' },
  },
  opts = {},
}
-- vim: ts=2 sts=2 sw=2 et

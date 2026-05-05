return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  cond = function() return vim.env.TMUX ~= nil end,
  keys = {
    { '<C-h>', '<cmd>TmuxNavigateLeft<CR>',  desc = 'Navigate left' },
    { '<C-j>', '<cmd>TmuxNavigateDown<CR>',  desc = 'Navigate down' },
    { '<C-k>', '<cmd>TmuxNavigateUp<CR>',    desc = 'Navigate up' },
    { '<C-l>', '<cmd>TmuxNavigateRight<CR>', desc = 'Navigate right' },
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
-- vim: ts=2 sts=2 sw=2 et

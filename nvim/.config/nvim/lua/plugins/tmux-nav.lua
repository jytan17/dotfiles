return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  cond = function() return vim.env.TMUX ~= nil end,
  keys = {
    { '<C-h>',     '<cmd>TmuxNavigateLeft<CR>',  desc = 'Navigate left' },
    { '<C-j>',     '<cmd>TmuxNavigateDown<CR>',  desc = 'Navigate down' },
    { '<C-k>',     '<cmd>TmuxNavigateUp<CR>',    desc = 'Navigate up' },
    { '<C-l>',     '<cmd>TmuxNavigateRight<CR>', desc = 'Navigate right' },
    { '<C-Left>',  '<cmd>TmuxNavigateLeft<CR>',  desc = 'Navigate left' },
    { '<C-Down>',  '<cmd>TmuxNavigateDown<CR>',  desc = 'Navigate down' },
    { '<C-Up>',    '<cmd>TmuxNavigateUp<CR>',    desc = 'Navigate up' },
    { '<C-Right>', '<cmd>TmuxNavigateRight<CR>', desc = 'Navigate right' },
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_no_wrap = 1

    -- Fallback: Ctrl-hjkl for split navigation when no multiplexer is active.
    if not vim.env.TMUX and not vim.env.ZELLIJ then
      vim.keymap.set('n', '<C-h>',     '<C-w>h', { desc = 'Navigate left' })
      vim.keymap.set('n', '<C-j>',     '<C-w>j', { desc = 'Navigate down' })
      vim.keymap.set('n', '<C-k>',     '<C-w>k', { desc = 'Navigate up' })
      vim.keymap.set('n', '<C-l>',     '<C-w>l', { desc = 'Navigate right' })
      vim.keymap.set('n', '<C-Left>',  '<C-w>h', { desc = 'Navigate left' })
      vim.keymap.set('n', '<C-Down>',  '<C-w>j', { desc = 'Navigate down' })
      vim.keymap.set('n', '<C-Up>',    '<C-w>k', { desc = 'Navigate up' })
      vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = 'Navigate right' })
    end
  end,
}
-- vim: ts=2 sts=2 sw=2 et

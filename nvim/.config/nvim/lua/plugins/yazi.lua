-- yazi.nvim: float yazi inside nvim
return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>y', '<cmd>Yazi<CR>', desc = 'Yazi (current file)' },
  },
}

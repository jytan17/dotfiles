-- lazygit.nvim: float lazygit inside nvim
return {
  'kdheepak/lazygit.nvim',
  cmd = { 'LazyGit', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<CR>',            desc = 'LazyGit (repo)' },
    { '<leader>gf', '<cmd>LazyGitCurrentFile<CR>', desc = 'LazyGit (current file repo)' },
  },
}

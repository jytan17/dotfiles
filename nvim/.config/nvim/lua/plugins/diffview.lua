-- diffview.nvim: side-by-side diffs + file history
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gv', '<cmd>DiffviewOpen<CR>',          desc = 'Diffview: open' },
    { '<leader>gV', '<cmd>DiffviewClose<CR>',         desc = 'Diffview: close' },
    { '<leader>gt', '<cmd>DiffviewFileHistory %<CR>', desc = 'Diffview: file history (current)' },
    { '<leader>gT', '<cmd>DiffviewFileHistory<CR>',   desc = 'Diffview: repo history' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = { layout = 'diff3_mixed' },
    },
  },
}

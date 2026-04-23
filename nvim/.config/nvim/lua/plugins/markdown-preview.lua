return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = 'cd app && npm install',
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Toggle markdown preview' },
  },
}
-- vim: ts=2 sts=2 sw=2 et

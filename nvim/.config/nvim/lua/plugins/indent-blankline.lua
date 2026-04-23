return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    indent = {
      char = '│',
    },
    scope = {
      enabled = false, -- mini.indentscope handles the active scope
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

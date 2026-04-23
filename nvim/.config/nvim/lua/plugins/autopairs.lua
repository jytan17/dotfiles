return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup({
      check_ts = true,              -- Use treesitter to check for pairs
      ts_config = {
        lua = { 'string' },         -- Don't add pairs in lua string treesitter nodes
        python = { 'string' },
      },
      fast_wrap = {
        map = '<M-e>',              -- Alt+e to fast wrap (surround next word with pair)
      },
      map_cr = true,                -- Smart Enter: split bracket pairs onto new lines
    })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

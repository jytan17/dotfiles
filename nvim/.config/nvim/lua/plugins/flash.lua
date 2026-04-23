return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    modes = {
      char = { enabled = true },
      search = { enabled = true },
    },
    label = {
      uppercase = false,
    },
  },
  keys = {
    { 'gw', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash jump' },
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote flash' },
    { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle flash search' },
  },
}
-- vim: ts=2 sts=2 sw=2 et

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.animate").setup({
      cursor = { enable = false }, -- Cursor animation can often feel sluggish even when fast
      scroll = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
      resize = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
      open = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
      close = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
    })
    require("mini.move").setup()
    require("mini.ai").setup()
    require("mini.indentscope").setup()
  end,
}

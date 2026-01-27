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
    local spec_treesitter = require("mini.ai").gen_spec.treesitter
    require("mini.ai").setup({
      custom_textobjects = {
        f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
        o = spec_treesitter({ a = { "@loop.outer", "@conditional.outer" }, i = { "@loop.inner", "@conditional.inner" } }),
        a = spec_treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
        b = spec_treesitter({ a = "@block.outer", i = "@block.inner" }),
      },
      -- Number of lines within which textobject is searched
      n_lines = 100,
    })
    require("mini.indentscope").setup()
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.pairs").setup()
  end,
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/tokyonight.nvim",
  },
  opts = {
    options = {
      theme = "tokyonight",
      icons_enabled = true,
      globalstatus = true,
    },
  },
}

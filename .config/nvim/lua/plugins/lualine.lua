return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      theme = "catppuccin",
      icons_enabled = true,
      globalstatus = true,
      disabled_filetypes = {
        winbar = { "neo-tree", "toggleterm", "TelescopePrompt" },
      },
    },
    winbar = {
      lualine_c = { "%=" }, -- push to right
      lualine_x = { { "filename", path = 1 } },
    },
    inactive_winbar = {
      lualine_c = { "%=" },
      lualine_x = { { "filename", path = 1, color = { fg = "#6c7086" } } }, -- dimmed when inactive
    },
  },
}

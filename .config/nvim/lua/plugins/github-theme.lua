return {
  "projekt0n/github-nvim-theme",
  priority = 1000,
  config = function()
    require("github-theme").setup({
      groups = {
        github_dark_high_contrast = {
          -- Neo-tree directory color
          NeoTreeDirectoryIcon = { fg = "#91cbff" },  -- Constant blue
          NeoTreeDirectoryName = { fg = "#91cbff" },  -- Constant blue
        },
      },
    })
    vim.cmd.colorscheme("github_dark_high_contrast")
  end,
}

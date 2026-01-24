return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function(_, opts)
    -- Required for queries (folds, highlights) to load properly
    vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")

    require("nvim-treesitter").setup(opts)
  end,
  opts = {
    ensure_installed = { "lua", "vim", "vimdoc" },
    auto_install = true,
  },
}

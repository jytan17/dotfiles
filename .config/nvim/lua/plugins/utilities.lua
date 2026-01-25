return {
  -- Auto-detect indent settings from file
  {
    "tpope/vim-sleuth",
  },

  -- Surround text objects (cs'" to change quotes, ysiw) to surround word with parens)
  {
    "kylechui/nvim-surround",
    version = "^2",
    event = "VeryLazy",
    opts = {},
  },

  -- Comment toggling (gcc for line, gc for selection)
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto-pair brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
  },
}

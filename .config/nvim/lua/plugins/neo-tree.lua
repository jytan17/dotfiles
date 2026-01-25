return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  event = "VimEnter",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    {
      "<leader>o",
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd("wincmd p")
        else
          vim.cmd("Neotree reveal")
        end
      end,
      desc = "Toggle Neo-tree focus",
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.cmd("Neotree show")
  end,
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 30,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
  },
}

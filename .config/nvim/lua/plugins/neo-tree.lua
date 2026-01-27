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
    if not vim.g.lazygit then
      vim.cmd("Neotree show")
    end
  end,
  opts = {
    hide_root_node = true, -- Don't show the root directory name
    enable_git_status = true,
    git_status_async = true, -- Run git status in background to prevent lags
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 30,
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["yp"] = function(state)
          local node = state.tree:get_node()
          local relative_path = vim.fn.fnamemodify(node:get_id(), ":.")
          vim.fn.setreg("+", relative_path)
          vim.notify("Copied: " .. relative_path)
        end,
        ["yP"] = function(state)
          local node = state.tree:get_node()
          local absolute_path = node:get_id()
          vim.fn.setreg("+", absolute_path)
          vim.notify("Copied: " .. absolute_path)
        end,
      },
    },
  },
}

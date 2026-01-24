return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
      group_empty_dirs = true,
    },
    git_status = {
      window = {
        position = "float",
      },
    },
    window = {
      width = 30,
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- Refresh neo-tree when Neovim regains focus (e.g., after using lazygit in another tmux pane)
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        local manager = require("neo-tree.sources.manager")
        local state = manager.get_state("filesystem")
        if state and state.tree then
          require("neo-tree.sources.filesystem.commands").refresh(state)
        end
      end,
    })
  end,
}

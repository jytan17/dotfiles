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
        local buf_name = vim.api.nvim_buf_get_name(0)
        if buf_name:match("neo%-tree") then
          vim.cmd("wincmd p")
        else
          vim.cmd("Neotree reveal")
        end
      end,
      desc = "Toggle Neo-tree focus",
    },
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

    -- Track if we're still in "startup mode" (full screen neo-tree)
    vim.g.neotree_startup_mode = true

    -- Open neo-tree full screen on startup
    vim.cmd("Neotree position=current")

    -- When a file is opened, switch neo-tree to sidebar
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        if not vim.g.neotree_startup_mode then
          return
        end
        local buf_name = vim.api.nvim_buf_get_name(0)
        local buf_type = vim.bo.buftype
        -- If entering a real file buffer (not neo-tree, not empty, not special)
        if buf_type == "" and buf_name ~= "" and not buf_name:match("neo%-tree") then
          vim.g.neotree_startup_mode = false
          vim.cmd("Neotree close")
          vim.cmd("Neotree show")
        end
      end,
    })

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

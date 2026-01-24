-- Neo-tree with "dashboard" behavior:
-- 1. Opens full screen on startup (like a file picker)
-- 2. Shrinks to sidebar when you open a file
-- 3. Returns to full screen when you :q the last file
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
      -- Toggle focus: if in neo-tree go back, if in file go to neo-tree
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
    close_if_last_window = false, -- Keep neo-tree open for dashboard behavior
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      group_empty_dirs = true,
    },
    git_status = {
      window = { position = "float" },
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = false, -- Pass through to which-key
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- Startup mode flag: true = full screen, false = sidebar
    vim.g.neotree_startup_mode = true
    vim.cmd("Neotree position=current")

    -- On first file open: switch from full screen to sidebar
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        if not vim.g.neotree_startup_mode then
          return
        end
        local buf_name = vim.api.nvim_buf_get_name(0)
        local buf_type = vim.bo.buftype
        if buf_type == "" and buf_name ~= "" and not buf_name:match("neo%-tree") then
          vim.g.neotree_startup_mode = false
          vim.cmd("Neotree close")
          vim.cmd("Neotree show")
        end
      end,
    })

    -- Refresh tree when nvim regains focus (e.g., after lazygit)
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        local manager = require("neo-tree.sources.manager")
        local state = manager.get_state("filesystem")
        if state and state.tree then
          require("neo-tree.sources.filesystem.commands").refresh(state)
        end
      end,
    })

    -- :Q command: if last window, return to full screen neo-tree instead of quitting
    vim.api.nvim_create_user_command("Q", function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      if buf_name:match("neo%-tree") then
        vim.cmd("q")
        return
      end

      -- Count non-neo-tree, non-floating windows
      local real_windows = 0
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local win_buf = vim.api.nvim_win_get_buf(win)
        local win_buf_name = vim.api.nvim_buf_get_name(win_buf)
        local win_config = vim.api.nvim_win_get_config(win)
        if not win_buf_name:match("neo%-tree") and win_config.relative == "" then
          real_windows = real_windows + 1
        end
      end

      if real_windows <= 1 then
        -- Last window: return to full screen neo-tree
        vim.g.neotree_startup_mode = true
        vim.cmd("Neotree close")
        vim.cmd("enew")
        vim.cmd("bdelete #")
        vim.cmd("Neotree position=current")
      else
        vim.cmd("q")
      end
    end, {})

    -- :Wq command: save then do smart quit
    vim.api.nvim_create_user_command("wQ", function()
      vim.cmd("w")
      vim.cmd("Q")
    end, {})

    -- Remap :q and :wq to use our custom commands
    vim.cmd("cabbrev q Q")
    vim.cmd("cabbrev wq wQ")
  end,
}

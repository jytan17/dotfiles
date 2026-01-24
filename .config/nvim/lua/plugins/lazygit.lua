return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*",
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

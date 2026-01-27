return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufRead",
  opts = {
    signs = false, -- specific toggle for sign column (gutter)
  },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    {
      "<leader>tt",
      function()
        local todo = require("todo-comments")
        local config = require("todo-comments.config")
        config.options.signs = not config.options.signs
        
        -- Safely reload the config
        todo.setup(config.options)
        
        -- Force a redraw of the current buffer to apply changes immediately
        vim.cmd("edit!")
        
        vim.notify("Todo signs: " .. (config.options.signs and "enabled" or "disabled"))
      end,
      desc = "Todo signs",
    },
  },
}

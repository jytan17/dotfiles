return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
    })

    -- Track toggle states
    local format_on_save = true

    wk.add({
      { "<leader>f", group = "find" },

      -- Toggle group
      { "<leader>t", group = "toggle" },
      {
        "<leader>tv",
        function()
          local config = vim.diagnostic.config()
          vim.diagnostic.config({ virtual_text = not config.virtual_text })
        end,
        desc = "Virtual text",
      },
      {
        "<leader>tg",
        function()
          local config = vim.diagnostic.config()
          vim.diagnostic.config({ signs = not config.signs })
        end,
        desc = "Gutter signs",
      },
      {
        "<leader>ti",
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        desc = "Inlay hints",
      },
      {
        "<leader>tr",
        function()
          vim.wo.relativenumber = not vim.wo.relativenumber
        end,
        desc = "Relative line numbers",
      },
      {
        "<leader>tn",
        function()
          vim.wo.number = not vim.wo.number
        end,
        desc = "Line numbers",
      },
      {
        "<leader>tw",
        function()
          vim.wo.wrap = not vim.wo.wrap
        end,
        desc = "Wrap",
      },
      {
        "<leader>ts",
        function()
          vim.wo.spell = not vim.wo.spell
        end,
        desc = "Spell check",
      },
      {
        "<leader>tf",
        function()
          format_on_save = not format_on_save
          vim.g.format_on_save = format_on_save
          vim.notify("Format on save: " .. (format_on_save and "enabled" or "disabled"))
        end,
        desc = "Format on save",
      },

      -- LSP group
      { "<leader>l", group = "lsp" },
      { "<leader>ld", vim.lsp.buf.definition, desc = "Go to definition" },
      { "<leader>lD", vim.lsp.buf.declaration, desc = "Go to declaration" },
      { "<leader>lr", vim.lsp.buf.references, desc = "References" },
      { "<leader>li", vim.lsp.buf.implementation, desc = "Implementation" },
      { "<leader>lt", vim.lsp.buf.type_definition, desc = "Type definition" },
      { "<leader>lR", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code action" },
      { "<leader>lh", vim.lsp.buf.hover, desc = "Hover" },
      { "<leader>ls", vim.lsp.buf.signature_help, desc = "Signature help" },
      { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
      { "<leader>ll", vim.diagnostic.open_float, desc = "Line diagnostics" },
      { "<leader>ln", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "<leader>lp", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },

      -- Quick actions
      { "<leader>w", "<cmd>w<cr>", desc = "Write" },
      { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
    })
  end,
}

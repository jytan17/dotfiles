return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Formatters
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "json", "yaml", "markdown" },
        }),

        -- Linters
        null_ls.builtins.diagnostics.hadolint, -- Dockerfile
        null_ls.builtins.diagnostics.shellcheck, -- Bash
      },
    })

    -- Format on save (respects toggle)
    vim.g.format_on_save = true
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        if vim.g.format_on_save then
          vim.lsp.buf.format({ async = false })
        end
      end,
    })
  end,
}

return {
  init_options = {
    settings = {
      -- Ignore specific rules (e.g., E501 = line too long, F401 = unused import)
      lint = {
        ignore = { "E501" },
      },
      -- Format settings
      format = {
        args = { "--line-length", "100" },
      },
    },
  },
  -- Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}

return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = { 'ConformInfo' },

  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      python = { 'ruff_organize_imports', 'ruff_format' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      lua = { 'stylua' },
      toml = { 'taplo' },
      json = { 'jq' },
      yaml = { 'yamlfmt' },
      markdown = { 'mdformat' },
      -- Trim trailing whitespace on any filetype without formatters
      ['_'] = { 'trim_whitespace' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500 }
    end,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
-- vim: ts=2 sts=2 sw=2 et

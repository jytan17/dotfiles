return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  init = function()
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = true,
      update_in_insert = false,
    })
  end,
  opts = {
    ensure_installed = {
      -- Python
      "basedpyright",
      "ruff",

      -- Lua
      "lua_ls",

      -- Markdown
      "marksman",

      -- JSON & YAML
      "jsonls",
      "yamlls",

      -- Docker
      "dockerls",
      "docker_compose_language_service",
    },
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)

    vim.lsp.enable({
      "basedpyright",
      "ruff",
      "lua_ls",
      "marksman",
      "jsonls",
      "yamlls",
      "dockerls",
      "docker_compose_language_service",
    })
  end,
}

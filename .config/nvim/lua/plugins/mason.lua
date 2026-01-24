return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        -- Python
        "basedpyright",
        "ruff",

        -- Markdown
        "marksman",

        -- JSON & YAML
        "jsonls",
        "yamlls",

        -- Docker
        "dockerls",
        "docker_compose_language_service",

        -- Lua (for neovim config)
        "lua_ls",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- Enable all LSP servers using the new Neovim 0.11+ API
      vim.lsp.enable({
        "basedpyright",
        "ruff",
        "marksman",
        "jsonls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
        "lua_ls",
      })
    end,
  },
}

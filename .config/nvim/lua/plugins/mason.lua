return {
  "mason-org/mason.nvim",
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)

    -- Auto-install these tools (formatters, linters, DAP)
    -- Note: LSPs are handled by mason-lspconfig in lsp.lua
    local ensure_installed = {
      -- Formatters
      "stylua",
      "prettier",

      -- Linters
      "hadolint",
      "shellcheck",

      -- DAP
      "debugpy",
    }

    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(ensure_installed) do
        local pkg = registry.get_package(name)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end)
  end,
}

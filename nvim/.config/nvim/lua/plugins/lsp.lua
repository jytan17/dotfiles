return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPost',
  dependencies = {
    -- Mason: auto-install LSP servers
    { 'williamboman/mason.nvim', opts = {} },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    -- ── Keymaps (set when an LSP attaches) ──────────────────
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-keymaps', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        -- Navigation (built-in vim/LSP — matches Zed defaults)
        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('gy', vim.lsp.buf.type_definition, 'Go to type definition')
        map('gI', vim.lsp.buf.implementation, 'Go to implementation')
        map('gA', vim.lsp.buf.references, 'Go to references')
        map('gh', vim.lsp.buf.hover, 'Hover info')

        -- Leader LSP keymaps (matching Zed: space l …)
        map('<leader>la', vim.lsp.buf.code_action, 'Code actions', { 'n', 'x' })
        map('<leader>lr', vim.lsp.buf.rename, 'Rename symbol')
        map('<leader>ld', vim.diagnostic.open_float, 'Line diagnostics')
        map('<leader>lf', function() vim.lsp.buf.format({ async = true }) end, 'Format file')
        map('<leader>lh', vim.lsp.buf.signature_help, 'Signature help')

        -- Pick-based LSP navigation (defined in mini.lua, but re-map here for buffer locality)
        map('<leader>ls', '<cmd>Pick buf_lines scope="current"<CR>', 'Document symbols')
        map('<leader>lS', '<cmd>Pick lsp scope="workspace_symbol"<CR>', 'Workspace symbols')
      end,
    })

    -- ── Diagnostics config ──────────────────────────────────
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = 'rounded', source = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      },
      virtual_text = {
        prefix = '●',
        spacing = 4,
      },
      underline = true,
    })

    -- Use curly underlines for diagnostics (Ghostty supports this)
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#f38ba8' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = '#f9e2af' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = '#89dceb' })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = '#a6e3a1' })

    -- ── Server configs ──────────────────────────────────────
    -- Each key is a server name, value is the config passed to lspconfig.setup()
    local servers = {
      -- Python (matches your Helix/Zed setup)
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'standard',
            },
          },
        },
      },
      ruff = {},

      -- Rust
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            check = { command = 'clippy' },
          },
        },
      },

      -- Markdown
      marksman = {},

      -- Docker
      dockerls = {},
      docker_compose_language_service = {},

      -- Data formats
      taplo = {},   -- TOML
      jsonls = {},  -- JSON
      yamlls = {    -- YAML
        settings = {
          yaml = {
            schemaStore = { enable = true },
          },
        },
      },

      -- Lua (for editing Neovim config)
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
          },
        },
      },
    }

    -- ── Mason auto-install ──────────────────────────────────
    local ensure_installed = vim.tbl_keys(servers)
    require('mason-lspconfig').setup({
      ensure_installed = ensure_installed,
      automatic_enable = true,
    })

    -- ── Setup each server ───────────────────────────────────
    local lspconfig = require('lspconfig')
    for server, config in pairs(servers) do
      lspconfig[server].setup(config)
    end
  end,
}
-- vim: ts=2 sts=2 sw=2 et

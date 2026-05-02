return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
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

        -- Disable hover for ruff (basedpyright handles it)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end

        -- Navigation (using snacks picker for preview support)
        map('gh', vim.lsp.buf.hover, 'Hover info')

        -- Leader LSP keymaps (matching Zed: space l …)
        map('<leader>la', vim.lsp.buf.code_action, 'Code actions', { 'n', 'x' })
        map('<leader>lr', vim.lsp.buf.rename, 'Rename symbol')
        map('<leader>ld', vim.diagnostic.open_float, 'Line diagnostics')
        map('<leader>lD', function() vim.diagnostic.setloclist() end, 'Diagnostics list')
        map('<leader>lf', function() require('conform').format({ async = true }) end, 'Format file')
        map('<leader>lh', vim.lsp.buf.signature_help, 'Signature help')

        -- Zed vim-mode aliases (g. for code actions, cd for rename)
        map('g.', vim.lsp.buf.code_action, 'Code actions (Zed)', { 'n', 'x' })
        map('cd', vim.lsp.buf.rename, 'Rename symbol (Zed)')
        -- LSP symbols and goto are handled by snacks.nvim picker (see snacks.lua)
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
        spacing = 2,
        prefix = '●',
      },
      virtual_lines = false,
      underline = true,
    })

    -- ── Server configs (vim.lsp.config API) ─────────────────
    -- Python
    vim.lsp.config('basedpyright', {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = 'standard',
          },
        },
      },
    })

    vim.lsp.config('ruff', {
      init_options = {
        settings = {
          lineLength = 120,
          lint = {
            select = { 'E', 'F', 'I' },
            ignore = {},
          },
          format = {
            ['quote-style'] = 'double',
            ['indent-style'] = 'space',
          },
        },
      },
    })

    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          check = { command = 'clippy' },
        },
      },
    })

    vim.lsp.config('marksman', {})
    vim.lsp.config('dockerls', {})
    vim.lsp.config('docker_compose_language_service', {})
    vim.lsp.config('taplo', {})
    vim.lsp.config('jsonls', {})
    vim.lsp.config('just', {})

    vim.lsp.config('yamlls', {
      settings = {
        yaml = {
          schemaStore = { enable = true },
        },
      },
    })

    vim.lsp.config('lua_ls', {
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
    })

    -- ── Mason auto-install + enable ─────────────────────────
    local server_names = {
      'basedpyright', 'ruff', 'rust_analyzer', 'marksman',
      'dockerls', 'docker_compose_language_service',
      'taplo', 'jsonls', 'yamlls', 'lua_ls', 'just',
    }

    require('mason-lspconfig').setup({
      ensure_installed = server_names,
      automatic_enable = false,
    })

    -- Enable all servers
    vim.lsp.enable(server_names)

    -- ── LspRestart command ──────────────────────────────────
    -- Not provided by default with vim.lsp.config/enable API
    -- Stops ALL matching clients (workspace-wide), not just buffer-local,
    -- so the server process fully restarts and re-scans the project.
    local function lsp_restart()
      -- Get clients for current buffer first, fall back to all clients
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        clients = vim.lsp.get_clients()
      end
      if #clients == 0 then
        -- No clients anywhere — just re-edit to trigger LSP attach
        vim.cmd('edit!')
        vim.notify('No LSP clients found — retriggered attach', vim.log.levels.INFO)
        return
      end
      -- Stop all unique servers (not just buffer-local instances)
      local seen = {}
      local names = {}
      for _, client in ipairs(clients) do
        if not seen[client.name] then
          seen[client.name] = true
          table.insert(names, client.name)
        end
      end
      -- Stop every instance of these servers across all buffers
      for _, c in ipairs(vim.lsp.get_clients()) do
        if seen[c.name] then c:stop() end
      end
      -- Re-edit to trigger re-attach after servers have shut down
      vim.defer_fn(function()
        vim.cmd('edit!')
        vim.notify('Restarted: ' .. table.concat(names, ', '), vim.log.levels.INFO)
      end, 500)
    end

    vim.api.nvim_create_user_command('LspRestart', lsp_restart, { desc = 'Restart all LSP clients' })
    vim.keymap.set('n', '<leader>lR', lsp_restart, { desc = 'Restart LSP' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

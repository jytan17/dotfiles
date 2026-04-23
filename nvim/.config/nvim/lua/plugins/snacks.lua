return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      layout = {
        cycle = true,
        preset = function()
          return vim.o.columns >= 120 and 'default' or 'vertical'
        end,
      },
      ui_select = true,
      formatters = {
        file = { filename_first = true },
      },
    },
    scroll = { enabled = true },
    dashboard = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    -- Find (space f …)
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find files' },
    { '<leader>fw', function() Snacks.picker.grep() end, desc = 'Find word (grep)' },
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Find buffers' },
    { '<leader>fh', function() Snacks.picker.help() end, desc = 'Find help' },
    { '<leader>fd', function() Snacks.picker.diagnostics() end, desc = 'Find diagnostics' },
    { '<leader>fr', function() Snacks.picker.resume() end, desc = 'Find resume' },
    { '<leader>f/', function() Snacks.picker.lines() end, desc = 'Find in buffer' },
    { '<leader>fo', function() Snacks.picker.recent() end, desc = 'Find recent files' },
    { '<leader>fk', function() Snacks.picker.keymaps() end, desc = 'Find keymaps' },

    -- LSP symbols (space l … + Zed vim aliases)
    { '<leader>ls', function() Snacks.picker.lsp_symbols() end, desc = 'Document symbols' },
    { '<leader>lS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Workspace symbols' },
    { 'gs', function() Snacks.picker.lsp_symbols() end, desc = 'Document symbols (Zed)' },
    { 'gS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Workspace symbols (Zed)' },

    -- LSP goto with preview
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto definition' },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto declaration' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto type definition' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto implementation' },
    { 'gA', function() Snacks.picker.lsp_references() end, desc = 'References' },

    -- Git (space g …)
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git status' },
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git log' },

    -- Zoom
    { '<C-.>', function() Snacks.zen.zoom() end, desc = 'Toggle zoom' },

    -- Zed vim alias: g/ for project-wide search
    { 'g/', function() Snacks.picker.grep() end, desc = 'Project search (Zed)' },
  },
}
-- vim: ts=2 sts=2 sw=2 et

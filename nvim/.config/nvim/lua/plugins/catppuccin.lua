return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000, -- Load before other plugins
  opts = {
    flavour = 'mocha',
    custom_highlights = function(colors)
      return {
        NormalFloat = { bg = colors.base },
        FloatBorder = { bg = colors.base, fg = colors.overlay0 },
        FloatTitle = { bg = colors.base, fg = colors.subtext1 },
        WinSeparator = { fg = colors.surface1, bg = 'NONE' },
        -- Curly underlines for diagnostics
        DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
        DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
        DiagnosticUnderlineInfo = { undercurl = true, sp = colors.sky },
        DiagnosticUnderlineHint = { undercurl = true, sp = colors.green },

        -- Stronger diff colors (used by diffview + builtin :diff)
        DiffAdd    = { bg = '#1e3a2a' },           -- whole added line
        DiffDelete = { bg = '#4a1e26', fg = '#4a1e26' }, -- whole removed line
        DiffChange = { bg = '#1e3147' },           -- changed line
        DiffText   = { bg = '#2d4a7a', bold = true }, -- changed token within line

        -- diffview-specific highlights
        DiffviewDiffAdd          = { bg = '#1e3a2a' },
        DiffviewDiffDelete       = { fg = '#585b70' },
        DiffviewDiffAddAsDelete  = { bg = '#4a1e26' },
        DiffviewDiffChange       = { bg = '#1e3147' },
        DiffviewDiffText         = { bg = '#2d4a7a', bold = true },
      }
    end,
    integrations = {
      mini = { enabled = true },
      native_lsp = { enabled = true },
      treesitter = true,
      mason = true,
      noice = true,
      blink_cmp = true,
      snacks = true,
      flash = true,
      neotree = true,
      ufo = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}
-- vim: ts=2 sts=2 sw=2 et

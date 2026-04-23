return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      hover = { enabled = true },
      signature = { enabled = false },
      progress = { enabled = false },
    },
    presets = {
      bottom_search = true,         -- Classic bottom search bar
      command_palette = true,        -- Command palette style cmdline
      long_message_to_split = true,  -- Long messages go to a split
      lsp_doc_border = true,         -- Bordered LSP docs
    },
    -- Use mini.notify as the backend for notifications
    notify = {
      enabled = true,
      view = 'mini',
    },
    -- Routes: suppress common noisy messages
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

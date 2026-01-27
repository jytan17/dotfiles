return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "thin",
    },
  },
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bb", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin" },
    { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick close" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close others" },
    { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete" },
  },
}

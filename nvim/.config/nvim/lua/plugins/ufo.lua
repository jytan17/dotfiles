return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
    { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    { 'zK', function()
      if not require('ufo').peekFoldedLinesUnderCursor() then
        vim.lsp.buf.hover()
      end
    end, desc = 'Peek fold' },
  },
  opts = {
    provider_selector = function(_, filetype, _)
      local ft_map = {
        vim = 'indent',
        git = '',
        [''] = '',
      }
      return ft_map[filetype] or { 'treesitter', 'indent' }
    end,
    -- Clean fold text: first line (syntax highlighted) ⋯ N lines
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local foldedLines = endLnum - lnum
      local suffix = ('  ⋯ %d lines '):format(foldedLines)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          table.insert(newVirtText, { chunkText, chunk[2] })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end

      -- Dimmed ellipsis + line count
      table.insert(newVirtText, { suffix, 'Comment' })
      return newVirtText
    end,
  },
  config = function(_, opts)
    -- Style the fold line background to be subtle
    vim.api.nvim_set_hl(0, 'Folded', { bg = 'NONE', fg = '#6c7086' })
    vim.api.nvim_set_hl(0, 'UfoFoldedEllipsis', { fg = '#6c7086' })
    require('ufo').setup(opts)
  end,
}
-- vim: ts=2 sts=2 sw=2 et

return {
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
  event = 'VeryLazy',
  config = function()
    local mc = require('multicursor-nvim')
    mc.setup()

    local set = vim.keymap.set

    -- Match word/selection (Zed: gl = next match, gL = all matches)
    set({ 'n', 'x' }, 'gl', function() mc.matchAddCursor(1) end, { desc = 'Add cursor at next match' })
    set({ 'n', 'x' }, 'gL', mc.matchAllAddCursors, { desc = 'Add cursor at all matches' })

    -- Operator: gaip adds cursor on each line of paragraph, etc.
    set({ 'n', 'x' }, 'ga', mc.addCursorOperator, { desc = 'Add cursor operator' })

    -- Add cursor above/below (Zed: g< / g>)
    set({ 'n', 'x' }, 'g>', function() mc.lineAddCursor(1) end, { desc = 'Add cursor below' })
    set({ 'n', 'x' }, 'g<', function() mc.lineAddCursor(-1) end, { desc = 'Add cursor above' })

    -- Skip match (complement to gl)
    set({ 'n', 'x' }, 'gS', function() mc.matchSkipCursor(1) end, { desc = 'Skip cursor match' })

    -- Zed vim-mode: gA in visual = cursor at end of each line, gI = at first char
    set('x', 'gA', mc.appendVisual, { desc = 'Add cursor end of each line' })
    set('x', 'gI', mc.insertVisual, { desc = 'Add cursor start of each line' })

    -- Mouse support
    set('n', '<c-leftmouse>', mc.handleMouse)
    set('n', '<c-leftdrag>', mc.handleMouseDrag)
    set('n', '<c-leftrelease>', mc.handleMouseRelease)

    -- Restore cleared cursors
    set('n', 'gV', mc.restoreCursors, { desc = 'Restore cursors' })

    -- Keymap layer: only active when multiple cursors exist
    mc.addKeymapLayer(function(layerSet)
      layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
      layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)
      layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor)
      layerSet('n', '<leader>a', mc.alignCursors)
      layerSet('x', 'S', mc.splitCursors)
      layerSet('x', 'M', mc.matchCursors)
      layerSet('x', '<leader>t', function() mc.transposeCursors(1) end)
      layerSet('x', '<leader>T', function() mc.transposeCursors(-1) end)

      layerSet('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Cursor highlights (Catppuccin-friendly)
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { reverse = true })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
    hl(0, 'MultiCursorDisabledCursor', { reverse = true })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_maps = {
      ["Add Cursor Down"] = "\\j",
      ["Add Cursor Up"] = "\\k",
    }
    vim.g.VM_Highlight_Cursor = 1
  end,
  config = function()
    -- Ensure multi-cursor colors are visible with Catppuccin
    -- These groups define how the "fake" cursors look
    vim.api.nvim_set_hl(0, "VM_Cursor", { link = "Cursor" })
    vim.api.nvim_set_hl(0, "VM_Insert", { link = "Cursor" })
  end,
}

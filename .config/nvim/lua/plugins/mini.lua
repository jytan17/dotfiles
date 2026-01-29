-- Treesitter navigation helper
local function goto_treesitter(capture, direction)
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_row, cursor_col = cursor[1] - 1, cursor[2]

  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  if not lang then return end

  local ok, query = pcall(vim.treesitter.query.get, lang, "textobjects")
  if not ok or not query then return end

  local parser = vim.treesitter.get_parser(bufnr, lang)
  if not parser then return end

  local tree = parser:parse()[1]
  local root = tree:root()

  local nodes = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == capture then
      local start_row, start_col = node:start()
      table.insert(nodes, { row = start_row, col = start_col })
    end
  end

  table.sort(nodes, function(a, b)
    if a.row ~= b.row then return a.row < b.row end
    return a.col < b.col
  end)

  local target = nil
  if direction == "next" then
    for _, n in ipairs(nodes) do
      if n.row > cursor_row or (n.row == cursor_row and n.col > cursor_col) then
        target = n
        break
      end
    end
  else
    for i = #nodes, 1, -1 do
      local n = nodes[i]
      if n.row < cursor_row or (n.row == cursor_row and n.col < cursor_col) then
        target = n
        break
      end
    end
  end

  if target then
    vim.api.nvim_win_set_cursor(0, { target.row + 1, target.col })
  end
end

-- Export navigation functions for use in keymaps
_G.ts_nav = {
  next_function = function() goto_treesitter("function.outer", "next") end,
  prev_function = function() goto_treesitter("function.outer", "prev") end,
  next_class = function() goto_treesitter("class.outer", "next") end,
  prev_class = function() goto_treesitter("class.outer", "prev") end,
}

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.animate").setup({
      cursor = { enable = false }, -- Cursor animation can often feel sluggish even when fast
      scroll = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
      resize = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
      open = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
      close = {
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      },
    })
    require("mini.move").setup()
    local spec_treesitter = require("mini.ai").gen_spec.treesitter
    require("mini.ai").setup({
      custom_textobjects = {
        f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
        o = spec_treesitter({ a = { "@loop.outer", "@conditional.outer" }, i = { "@loop.inner", "@conditional.inner" } }),
        -- Note: 'a' for argument, 'b' for brackets are mini.ai defaults - don't override
      },
      -- Number of lines within which textobject is searched
      n_lines = 100,
    })
    require("mini.indentscope").setup()
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.pairs").setup()
    require("mini.cursorword").setup()
  end,
}

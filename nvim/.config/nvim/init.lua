-- Neovim Configuration
-- Leader key must be set before plugins load
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Options ]]
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.laststatus = 3             -- Global statusline (single bar across splits)
vim.opt.fillchars = { vert = '│', horiz = '─', horizup = '┴', horizdown = '┬', vertleft = '┤', vertright = '├', verthoriz = '┼' }
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.wildmode = 'longest:full,full' -- Tab cycles completion menu
vim.opt.wildoptions = { 'pum', 'fuzzy' } -- Popup menu + fuzzy match in cmdline
vim.o.pumheight = 12 -- Limit popup menu height
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = false  -- Use plain E37 error on :q with unsaved changes; use :q!/:wq explicitly
vim.o.termguicolors = true
vim.o.wrap = false

-- Folding: managed by nvim-ufo (za to toggle, zR/zM open/close all, zK to peek)
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Sync clipboard
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Python indent: hanging indent style (one shiftwidth) instead of alignment
-- See :help ft-python-indent
vim.g.python_indent = {
  open_paren = 'shiftwidth()',
  nested_paren = 'shiftwidth()',
  continue = 'shiftwidth()',
  closed_paren_align_last_line = false,
}

-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move lines up/down (VS Code style: Opt+Up / Opt+Down)
vim.keymap.set('n', '<A-Up>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('n', '<A-Down>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('i', '<A-Up>', '<Esc><cmd>m .-2<CR>==gi', { desc = 'Move line up' })
vim.keymap.set('i', '<A-Down>', '<Esc><cmd>m .+1<CR>==gi', { desc = 'Move line down' })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- Opt+Backspace deletes previous word (macOS style, insert + command-line mode)
vim.keymap.set('i', '<A-BS>', '<C-w>', { desc = 'Delete word backward' })
vim.keymap.set('c', '<A-BS>', '<C-w>', { desc = 'Delete word backward' })

-- Yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Unlock Zellij when leaving Neovim (zellij-nav uses locked mode)
vim.api.nvim_create_autocmd('VimLeave', {
  pattern = '*',
  command = 'silent !zellij action switch-mode normal',
})

-- [[ Install lazy.nvim ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Plugins ]]
require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂', init = '⚙',
      keys = '🗝', plugin = '🔌', runtime = '💻', require = '🌙',
      source = '📄', start = '🚀', task = '📌', lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et

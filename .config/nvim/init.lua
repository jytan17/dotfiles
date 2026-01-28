vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- True color support (required for undercurls)
vim.opt.termguicolors = true

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Faster update time for better UI responsiveness (default is 4000ms)
vim.opt.updatetime = 250

-- Disable line wrapping
vim.opt.wrap = false

-- Search settings
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ...unless you type a capital

-- Clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Use jk to escape to normal mode
vim.keymap.set("i", "jk", "<Esc>")

-- Disable LSP semantic tokens (let Treesitter handle highlighting)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

-- Treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- Start with all folds open

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Open PDF files in Windows viewer via WSL
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "*.pdf",
	callback = function()
		local file = vim.fn.expand("%:p")
		vim.fn.system({ "wslview", file })
		vim.cmd("bdelete")
	end,
})

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "catppuccin", "habamax" } },
	checker = { enabled = true },
})

-- Global Toggles
require("toggles").setup()

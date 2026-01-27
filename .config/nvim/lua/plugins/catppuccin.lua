return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
				},
			},
			custom_highlights = function(colors)
				return {
					DiagnosticUnderlineError = { undercurl = true },
					DiagnosticUnderlineWarn = { undercurl = true },
					DiagnosticUnderlineInfo = { undercurl = true },
					DiagnosticUnderlineHint = { undercurl = true },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

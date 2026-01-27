return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			term_colors = true,
			color_overrides = {
				mocha = {
					base = "#15152a",
				},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				todo_comments = true,
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
					NeoTreeNormal = { bg = "#0d0d17" },
					NeoTreeNormalNC = { bg = "#0d0d17" },

					-- Make Sticky Context (Outline) more obvious
					TreesitterContext = { bg = "#252540" },
					TreesitterContextLineNumber = { bg = "#252540", fg = colors.rosewater },
					TreesitterContextBottom = { sp = colors.rosewater, style = { "underline" } },

					-- Make Indent Scope line brighter
					MiniIndentscopeSymbol = { fg = colors.pink, style = { "bold" } },

					-- Winbar border (underline to separate from buffer)
					WinBar = { sp = colors.surface1, style = { "underline" } },
					WinBarNC = { sp = colors.surface0, style = { "underline" } },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

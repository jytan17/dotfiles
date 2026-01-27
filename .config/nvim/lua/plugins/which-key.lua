return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			preset = "helix",
		})

		-- Track toggle states
		local format_on_save = true

		wk.add({
			{ "<leader>f", group = "find", icon = "\u{ea6d}" }, -- nf-cod-search

			-- Toggle group
			{ "<leader>t", group = "toggle", icon = { icon = "\u{f204}", color = "yellow" } }, -- nf-cod-record
			{
				"<leader>tv",
				function()
					local config = vim.diagnostic.config()
					vim.diagnostic.config({ virtual_lines = not config.virtual_lines })
				end,
				desc = "Virtual lines",
				icon = { icon = "\u{f0269}", color = "yellow" }, -- nf-md-format_line_spacing
			},
			{
				"<leader>tg",
				function()
					local config = vim.diagnostic.config()
					vim.diagnostic.config({ signs = not config.signs })
				end,
				desc = "Gutter signs",
				icon = { icon = "\u{ea7b}", color = "yellow" }, -- nf-cod-issue_opened
			},
			{
				"<leader>ti",
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end,
				desc = "Inlay hints",
				icon = { icon = "\u{ea61}", color = "yellow" }, -- nf-cod-lightbulb
			},
			{
				"<leader>tr",
				function()
					vim.wo.relativenumber = not vim.wo.relativenumber
				end,
				desc = "Relative line numbers",
				icon = { icon = "\u{f292}", color = "yellow" }, -- nf-fa-hashtag
			},
			{
				"<leader>tn",
				function()
					vim.wo.number = not vim.wo.number
				end,
				desc = "Line numbers",
				icon = { icon = "\u{f03a1}", color = "yellow" }, -- nf-md-format_list_numbered
			},
			{
				"<leader>tw",
				function()
					vim.wo.wrap = not vim.wo.wrap
				end,
				desc = "Wrap",
				icon = { icon = "\u{f05b6}", color = "yellow" }, -- nf-md-wrap
			},
			{
				"<leader>ts",
				function()
					vim.wo.spell = not vim.wo.spell
				end,
				desc = "Spell check",
				icon = { icon = "\u{efb3}", color = "yellow" }, -- nf-md-spellcheck
			},
			{
				"<leader>tf",
				function()
					format_on_save = not format_on_save
					vim.g.format_on_save = format_on_save
					vim.notify("Format on save: " .. (format_on_save and "enabled" or "disabled"))
				end,
				desc = "Format on save",
				icon = { icon = "\u{f027b}", color = "yellow" }, -- nf-md-format_paint
			},

			-- LSP group
			{ "<leader>l", group = "lsp", icon = "\u{eac4}" }, -- nf-cod-code
			{
				"<leader>ld",
				vim.lsp.buf.definition,
				desc = "Definition",
				icon = "\u{f0295}",
			}, -- nf-md-function_variant
			{
				"<leader>lD",
				vim.lsp.buf.declaration,
				desc = "Declaration",
				icon = "\u{eb5f}",
			}, -- nf-cod-symbol_variable
			{
				"<leader>lr",
				vim.lsp.buf.references,
				desc = "References",
				icon = "\u{eb36}",
			}, -- nf-cod-references
			{
				"<leader>li",
				vim.lsp.buf.implementation,
				desc = "Implementation",
				icon = "\u{f0317}",
			}, -- nf-md-code_braces
			{
				"<leader>lt",
				vim.lsp.buf.type_definition,
				desc = "Type definition",
				icon = "\u{ea92}",
			}, -- nf-cod-symbol_class
			{
				"<leader>lR",
				vim.lsp.buf.rename,
				desc = "Rename",
				icon = "\u{f0453}",
			}, -- nf-md-rename_box
			{
				"<leader>la",
				vim.lsp.buf.code_action,
				desc = "Code action",
				icon = "\u{ea61}",
			}, -- nf-cod-lightbulb
			{
				"<leader>lh",
				vim.lsp.buf.hover,
				desc = "Hover",
				icon = "\u{ea74}",
			}, -- nf-cod-info
			{
				"<leader>lf",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				desc = "Format",
				icon = "\u{eba9}",
			}, -- nf-cod-wand
			{
				"<leader>ll",
				vim.diagnostic.open_float,
				desc = "Line diagnostics",
				icon = "\u{ea6c}",
			}, -- nf-cod-warning
			{
				"<leader>ln",
				vim.diagnostic.goto_next,
				desc = "Next diagnostic",
				icon = "\u{f105}",
			}, -- nf-fa-angle_right
			{
				"<leader>lp",
				vim.diagnostic.goto_prev,
				desc = "Prev diagnostic",
				icon = "\u{f104}",
			}, -- nf-fa-angle_left

			-- Quick actions
			{
				"<leader>q",
				"<cmd>q<cr>",
				desc = "Quit",
				icon = "\u{f426}",
			}, -- nf-md-door

			-- Groups for other plugins
			{ "<leader>b", group = "buffer", icon = "\u{ef96}" }, -- nf-md-buffer
			{ "<leader>bp", icon = "\u{eb2b}" }, -- nf-cod-pinned
			{ "<leader>bc", icon = "\u{eab4}" }, -- nf-cod-close
			{ "<leader>bo", icon = "\u{eab5}" }, -- nf-cod-close_all
			{ "<leader>bd", icon = "\u{ea76}" }, -- nf-cod-trash
			{ "<leader>s", group = "split", icon = "\u{eb56}" }, -- nf-cod-split_horizontal
			{ "<leader>sv", icon = "\u{eb56}" }, -- nf-cod-split_horizontal (vertical split)
			{ "<leader>ss", icon = "\u{eb57}" }, -- nf-cod-split_vertical (horizontal split)
			{ "<leader>sc", icon = "\u{f00d}" }, -- nf-fa-close
			{ "<leader>se", icon = "\u{e279}" }, -- nf-oct-horizontal_rule
			{ "<leader>w", group = "window", icon = "\u{eb7f}" }, -- nf-cod-window
			{ "<leader>wh", icon = "\u{f104}" }, -- nf-fa-angle_left
			{ "<leader>wj", icon = "\u{f107}" }, -- nf-fa-angle_down
			{ "<leader>wk", icon = "\u{f106}" }, -- nf-fa-angle_up
			{ "<leader>wl", icon = "\u{f105}" }, -- nf-fa-angle_right
			{ "<leader>g", group = "git", icon = "\u{e725}" }, -- nf-dev-git_branch
			{ "<leader>d", group = "debug", icon = "\u{ead8}" }, -- nf-cod-debug_alt
			{ "<leader>db", icon = "\u{eaa7}" }, -- nf-cod-circle_large_outline
			{ "<leader>dc", icon = "\u{ead3}" }, -- nf-cod-debug_start
			{ "<leader>do", icon = "\u{ead6}" }, -- nf-cod-debug_step_over
			{ "<leader>di", icon = "\u{ead4}" }, -- nf-cod-debug_step_into
			{ "<leader>du", icon = "\u{ead6}" }, -- nf-cod-debug_step_over
		})
	end,
}

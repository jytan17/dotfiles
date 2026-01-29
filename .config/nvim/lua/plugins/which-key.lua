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

			-- Next group
			{ "<leader>n", group = "next", icon = "\u{eab6}" }, -- nf-cod-arrow_right
			{
				"<leader>nd",
				vim.diagnostic.goto_next,
				desc = "Next diagnostic",
				icon = "\u{ea6c}",
			}, -- nf-cod-warning
			{
				"<leader>nh",
				function()
					if vim.wo.diff then return "]c" end
					vim.schedule(function() require("gitsigns").next_hunk() end)
					return "<Ignore>"
				end,
				desc = "Next git hunk",
				icon = "\u{e725}",
			}, -- nf-dev-git_branch
			{
				"<leader>nt",
				function() require("todo-comments").jump_next() end,
				desc = "Next todo",
				icon = "\u{f00c}",
			}, -- nf-fa-check

			-- Previous group
			{ "<leader>p", group = "prev", icon = "\u{eab4}" }, -- nf-cod-arrow_left
			{
				"<leader>pd",
				vim.diagnostic.goto_prev,
				desc = "Prev diagnostic",
				icon = "\u{ea6c}",
			}, -- nf-cod-warning
			{
				"<leader>ph",
				function()
					if vim.wo.diff then return "[c" end
					vim.schedule(function() require("gitsigns").prev_hunk() end)
					return "<Ignore>"
				end,
				desc = "Prev git hunk",
				icon = "\u{e725}",
			}, -- nf-dev-git_branch
			{
				"<leader>pt",
				function() require("todo-comments").jump_prev() end,
				desc = "Prev todo",
				icon = "\u{f00c}",
			}, -- nf-fa-check

			-- Trouble group
			{ "<leader>x", group = "trouble", icon = "\u{ea6c}" }, -- nf-cod-warning

			-- Toggle group
			{ "<leader>t", group = "toggle", icon = { icon = "\u{f204}", color = "yellow" } }, -- nf-cod-record
			{
				"<leader>tv",
				function() require("toggles").toggle("virtual_lines") end,
				desc = "Virtual lines",
				icon = { icon = "\u{f0269}", color = "yellow" }, -- nf-md-format_line_spacing
			},
			{
				"<leader>tg",
				function() require("toggles").toggle("git") end,
				desc = "Git signs",
				icon = { icon = "\u{f1d3}", color = "yellow" }, -- nf-fa-git
			},
			{
				"<leader>td",
				function() require("toggles").toggle("diagnostics") end,
				desc = "Diagnostic signs",
				icon = { icon = "\u{ea7b}", color = "yellow" }, -- nf-cod-issue_opened
			},
			{
				"<leader>ti",
				function() require("toggles").toggle("inlay_hints") end,
				desc = "Inlay hints",
				icon = { icon = "\u{ea61}", color = "yellow" }, -- nf-cod-lightbulb
			},
			{
				"<leader>tr",
				function() require("toggles").toggle("relativenumber") end,
				desc = "Relative line numbers",
				icon = { icon = "\u{f292}", color = "yellow" }, -- nf-fa-hashtag
			},
			{
				"<leader>tn",
				function() require("toggles").toggle("number") end,
				desc = "Line numbers",
				icon = { icon = "\u{f03a1}", color = "yellow" }, -- nf-md-format_list_numbered
			},
			{
				"<leader>tw",
				function() require("toggles").toggle("wrap") end,
				desc = "Wrap",
				icon = { icon = "\u{f05b6}", color = "yellow" }, -- nf-md-wrap
			},
			{
				"<leader>ts",
				function() require("toggles").toggle("spell") end,
				desc = "Spell check",
				icon = { icon = "\u{efb3}", color = "yellow" }, -- nf-md-spellcheck
			},
			{
				"<leader>tt",
				function() require("toggles").toggle("todos") end,
				desc = "Todo signs",
				icon = { icon = "\u{f00c}", color = "yellow" }, -- nf-fa-check
			},
			{
				"<leader>tf",
				function() require("toggles").toggle("format_on_save") end,
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

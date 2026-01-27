return {
	-- Git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			signs = {
				add = { text = "▎", hl = "GitSignsAdd" },
				change = { text = "▎", hl = "GitSignsChange" },
				delete = { text = "\u{25bc}", hl = "GitSignsDelete" }, -- ▼ (Thick triangle)
				topdelete = { text = "\u{25b2}", hl = "GitSignsDelete" }, -- ▲
				changedelete = { text = "▎", hl = "GitSignsChange" },
				untracked = { text = "▎", hl = "GitSignsAdd" },
			},
			current_line_blame = false, -- Show blame ghost text by default
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 200,
				ignore_whitespace = false,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, "Next Hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, "Prev Hunk")

				-- Actions (Git Group)
				map("n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
				map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
				map("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage Hunk (Visual)")
				map("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset Hunk (Visual)")
				map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>gd", gs.diffthis, "Diff This")
				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map("n", "<leader>gq", "<cmd>diffoff! | only<cr>", "Quit Diff View")

				-- Toggles (Toggle Group)
				map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle git blame")
			end,
		},
	},
}

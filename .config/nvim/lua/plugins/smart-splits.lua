return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	opts = {
		ignored_filetypes = { "nofile", "quickfix", "prompt" },
		ignored_buftypes = { "NvimTree" },
	},
	keys = {
		-- Resizing
		{
			"<A-h>",
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize left",
		},
		{
			"<A-j>",
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize down",
		},
		{
			"<A-k>",
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize up",
		},
		{
			"<A-l>",
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize right",
		},

		-- Swapping buffers between windows
		{
			"<leader>wh",
			function()
				require("smart-splits").swap_buf_left()
			end,
			desc = "Swap left",
		},
		{
			"<leader>wj",
			function()
				require("smart-splits").swap_buf_down()
			end,
			desc = "Swap down",
		},
		{
			"<leader>wk",
			function()
				require("smart-splits").swap_buf_up()
			end,
			desc = "Swap up",
		},
		{
			"<leader>wl",
			function()
				require("smart-splits").swap_buf_right()
			end,
			desc = "Swap right",
		},

		-- Split creation
		{ "<leader>sv", "<cmd>vsplit<cr>", desc = "Vertical" },
		{ "<leader>ss", "<cmd>split<cr>", desc = "Horizontal" },
		{ "<leader>sc", "<cmd>close<cr>", desc = "Close" },
		{ "<leader>se", "<C-w>=", desc = "Equalize" },
	},
}

return {
	"sphamba/smear-cursor.nvim",
	enabled = function()
		return vim.env.TERM_PROGRAM ~= "ghostty"
	end,
	opts = {
		stiffness = 0.8,
		trailing_stiffness = 0.5,
		distance_stop_animating = 0.5,
		hide_target_hack = false,
	},
}

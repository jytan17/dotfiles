local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font settings (matching Alacritty)
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 15

-- Window settings
config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}

-- Cursor settings (no blinking)
config.default_cursor_style = "SteadyBlock"
config.animation_fps = 60
config.force_reverse_video_cursor = false

-- WezTerm doesn't support cursor trails natively
-- For cursor trails in Neovim, use Neovide (GUI) or mini.animate
config.webgpu_power_preference = "HighPerformance"

-- Catppuccin Mocha color scheme (matching Alacritty config)
config.colors = {
	foreground = "#cdd6f4",
	background = "#15152a",

	cursor_fg = "#1e1e2e",
	cursor_bg = "#f5e0dc",
	cursor_border = "#f5e0dc",

	selection_fg = "#cdd6f4",
	selection_bg = "#585b70",

	scrollbar_thumb = "#585b70",

	split = "#6c7086",

	ansi = {
		"#45475a", -- black
		"#f38ba8", -- red
		"#a6e3a1", -- green
		"#f9e2af", -- yellow
		"#89b4fa", -- blue
		"#f5c2e7", -- magenta
		"#94e2d5", -- cyan
		"#bac2de", -- white
	},

	brights = {
		"#585b70", -- bright black
		"#f38ba8", -- bright red
		"#a6e3a1", -- bright green
		"#f9e2af", -- bright yellow
		"#89b4fa", -- bright blue
		"#f5c2e7", -- bright magenta
		"#94e2d5", -- bright cyan
		"#a6adc8", -- bright white
	},

	-- Tab bar colors
	tab_bar = {
		background = "#1e1e2e",
		active_tab = {
			bg_color = "#cba6f7",
			fg_color = "#1e1e2e",
		},
		inactive_tab = {
			bg_color = "#313244",
			fg_color = "#cdd6f4",
		},
		inactive_tab_hover = {
			bg_color = "#45475a",
			fg_color = "#cdd6f4",
		},
		new_tab = {
			bg_color = "#1e1e2e",
			fg_color = "#cdd6f4",
		},
		new_tab_hover = {
			bg_color = "#45475a",
			fg_color = "#cdd6f4",
		},
	},
}

-- Tab bar settings
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Disable annoying default behaviors
config.audible_bell = "Disabled"
config.enable_scroll_bar = false

-- Performance
config.max_fps = 120
config.front_end = "WebGpu"

return config

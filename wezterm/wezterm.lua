local wezterm = require("wezterm")

local my_fonts = {
    wezterm.font {
        family = "JetBrainsMono Nerd Font",
        weight = "Regular",
        bold = false,
        italic = false,
    },
    wezterm.font {
        family = "rissole",
        weight = "Regular",
        bold = false,
        italic = false,
    },
}

local colors = {
    "Green Screen (base16)",
    "Gruvbox dark, medium (base16)",
    "Everforest",
}

return {
	hide_tab_bar_if_only_one_tab = true,
    window_close_confirmation = 'NeverPrompt',
	freetype_interpreter_version = 38,
	-- freetype_load_flags = 'DEFAULT',
	freetype_load_flags = "FORCE_AUTOHINT",
	font = my_fonts[1],
	font_size = 8,
    color_scheme_dirs = { '/home/luis/.config/wezterm/colors/' },
	color_scheme = colors[3],
    window_background_opacity = 0.8,
}

local wezterm = require("wezterm")

local fonts = {
    "JetBrainsMono Nerd Font",
    "rissole",
    "Cozette",
}

local cfont = fonts[3]

local colors = {
    "Green Screen (base16)",
    "Gruvbox dark, medium (base16)",
    "Everforest",
    "Solarized Dark - Patched"
}

return {
	hide_tab_bar_if_only_one_tab = true,
    window_close_confirmation = 'NeverPrompt',
	freetype_interpreter_version = 38,
	-- freetype_load_flags = 'DEFAULT',
	freetype_load_flags = "FORCE_AUTOHINT",
    freetype_load_target = "Normal", -- "HorizontalLcd", "Mono", "Light", "Normal"
	font = wezterm.font {
        family = cfont,
        weight = "Regular",
        bold = false,
        italic = false,
    },
    font_rules = {
        {
            intensity = 'Normal',
            italic = true,
            font = wezterm.font {
                family = cfont,
                weight = "Regular",
                italic = false,
            },
        },
        {
            intensity = 'Bold',
            italic = false,
            font = wezterm.font {
                family = cfont,
                weight = 'Regular',
                italic = false,
            },
        },
    },
	font_size = 8,
    color_scheme_dirs = { '/home/luis/.config/wezterm/colors/' },
	color_scheme = colors[4],
    window_background_opacity = 0.9,
}

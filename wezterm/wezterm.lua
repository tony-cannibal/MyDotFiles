local wezterm = require("wezterm")

local fonts = {
    "JetBrainsMono Nerd Font",
    "rissole",
    "Cozette",
    "PxPlus IBM VGA 8x14",
    "MorePerfectDOSVGA Nerd Font",
}

local cfont = fonts[3]

local colors = {
    "Green Screen (base16)",
    "Gruvbox dark, medium (base16)",
    "Everforest",
    "Solarized Dark - Patched",
    "Matrix (terminal.sexy)"
}

return {
	hide_tab_bar_if_only_one_tab = true,
    window_close_confirmation = 'NeverPrompt',
	freetype_interpreter_version = 38,
	-- freetype_load_flags = 'DEFAULT',
	freetype_load_flags = "FORCE_AUTOHINT",
    freetype_load_target = "Mono", -- "HorizontalLcd", "Mono", "Light", "Normal"
	font = wezterm.font {
        family = cfont,
        weight = "Regular",
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
	font_size = 10,
    color_scheme_dirs = { '/home/luis/.config/wezterm/colors/' },
	color_scheme = colors[5],
    window_background_opacity = 0.9,
}

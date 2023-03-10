local color_chemes = {
    "gruvbox-material",  -- 1
    "everforest",        -- 2
    "sonokai",           -- 3
    "solarized",        -- 4
    "komau",             -- 5
    "gruvbox",           -- 6
    "pywal",             -- 7
    "xresources",        -- 8
}

local transparent = true

--{{ Sonokai Styles
--   'default'
--   'atlantis'
--   'andromeda'
--   'shusia'
--   'maia'
--   'espresso'
--}}

function ColorScheme(color, trans)

    color = color or "solarized8"
    -- Set Transparent Background
    if color == color_chemes[1] then
        vim.cmd[[
            let g:gruvbox_material_background = 'medium'
            let g:gruvbox_material_better_performance = 1
            ]]
    end
    if color == color_chemes[2] then
        vim.cmd[[
            let g:everforest_background = 'hard'
            let g:everforest_better_performance = 1
            ]]
    end
    if color == color_chemes[3] then
        vim.cmd[[
            let g:sonokai_style = 'default'
            let g:sonokai_better_performance = 1
            ]]
    end

    if color == "gruvbox" then 
        vim.cmd[[
            set background=dark
            let g:gruvbox_contrast_dark = 'medium'
            let g:gruvbox_contrast_light = 'soft'
        ]]
    end

    vim.cmd.colorscheme(color)

    if trans == true then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

-- 1 = gruvbox-material
-- 2 = everforest         eveforest
-- 3 = sonokai
-- 4 = solarized8
-- 5 = komau              steamburn
-- 6 = gruvbox
-- 7 = pywal
-- 8 = xresources

ColorScheme(color_chemes[4], transparent)



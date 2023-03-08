local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi

local lain = require("lain")

local scripts = os.getenv("HOME") .. "/.config/awesome/scripts/"

local span1 = '<span foreground="'

local M = {}

local icon = '<span foreground="'.. beautiful.fg_accent .. '">'
local s_end = "</span>"

M.mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Volume Widget
M.vol_icon = wibox.widget.textbox(icon .." " .. s_end)


M.vol_bar = wibox.widget {
    max_value = 1,
    forced_height    = dpi(1),
    forced_width     = dpi(57),
    color            = beautiful.fg_normal,
    background_color = beautiful.bg_normal,
    -- shape            = gears.shape.rounded_bar,
    -- bar_shape        = gears.shape.rounded_bar,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = dpi(5),
    widget           = wibox.widget.progressbar,
}


M.volume, M.vol_signal = awful.widget.watch(scripts .. "get-volume.sh", 1,
    function(_, stdout)
        -- local value = tonumber(stdout)/100
        local value = tonumber(stdout)/100
        if value == 2 then
            M.vol_bar:set_value(1)
            M.vol_bar:set_color(beautiful.bg_urgent)
        else
            M.vol_bar:set_value(value)
            M.vol_bar:set_color(beautiful.fg_normal)
        end
    end)


M.volbg = wibox.container.background(M.vol_bar, "#474747", gears.shape.rectangle)
--                                             left,   right, top,    bottom
M.volwidget = wibox.container.margin(M.volbg, dpi(2), dpi(2), dpi(4), dpi(4))

M.volwidget:buttons(gears.table.join(
    awful.button({}, 1, function()awful.spawn.with_line_callback(
            "pamixer -t", { exit =  function() M.vol_signal:emit_signal("timeout") end}
            )end),
    awful.button({}, 4, function()awful.spawn.with_line_callback(
            "pamixer -i 5", { exit =  function() M.vol_signal:emit_signal("timeout") end}
            )end),
    awful.button({}, 5, function()awful.spawn.with_line_callback(
            "pamixer -d 5", { exit =  function() M.vol_signal:emit_signal("timeout") end}
            )end)
            ))

-- }}}


-- {{{ Mem Widget
M.mem_icon = wibox.widget.textbox(icon .. ' ' .. s_end)


M.mem_bar = wibox.widget {
    -- max_value = 1,
    forced_height    = dpi(1),
    forced_width     = dpi(57),
    color            = beautiful.fg_normal,
    background_color = beautiful.bg_normal,
    -- shape            = gears.shape.rounded_bar,
    -- bar_shape        = gears.shape.rounded_bar,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = dpi(5),
    widget           = wibox.widget.progressbar,
}

M.memory, M.mem_signal = awful.widget.watch(scripts .. "get-mem.sh", 2,
    function(widget, stdout)
        widget:set_text(stdout)
        -- local value = tonumber(stdout)/100
        local value = tonumber(stdout)
        if value >= 0.85 then
            M.mem_bar:set_value(value)
            M.mem_bar:set_color(beautiful.bg_urgent)
        else
            M.mem_bar:set_value(value)
            M.mem_bar:set_color(beautiful.fg_normal)
    end
    end)


M.membg = wibox.container.background(M.mem_bar, beautiful.bg_widget, gears.shape.rectangle)
--                                             left,   right, top,    bottom
M.memwidget = wibox.container.margin(M.membg, dpi(2), dpi(2), dpi(4), dpi(4))
-- }}}

-- {{{ Filesystem Widget
M.file_icon = wibox.widget.textbox(icon .. ' ' .. s_end)


M.file_bar = wibox.widget {
    -- max_value = 1,
    forced_height    = dpi(1),
    forced_width     = dpi(57),
    color            = beautiful.fg_normal,
    background_color = beautiful.bg_normal,
    -- shape            = gears.shape.rounded_bar,
    -- bar_shape        = gears.shape.rounded_bar,
    margins          = 1,
    paddings         = 1,
    ticks            = true,
    ticks_size       = dpi(5),
    widget           = wibox.widget.progressbar,
}

M.space, M.file_signal = awful.widget.watch(scripts .. "get-space.sh", 2,
    function(widget, stdout)
        widget:set_text(stdout)
        local value = tonumber(stdout)
        if value >= 0.85 then
            M.file_bar:set_value(value)
            M.file_bar:set_color(beautiful.bg_urgent)
        else
            M.file_bar:set_value(value)
            M.file_bar:set_color(beautiful.fg_normal)
    end
    end)


M.filebg = wibox.container.background(M.file_bar, beautiful.bg_widget, gears.shape.rectangle)
--                                             left,   right, top,    bottom
M.filewidget = wibox.container.margin(M.filebg, dpi(2), dpi(2), dpi(4), dpi(4))
-- }}}

M.clock_icon = wibox.widget.textbox(icon .. ' ' .. s_end)

M.mytextclock = wibox.widget.textclock("%I:%M %p ")


M.sep = wibox.widget.textbox(' ')


M.mympd = lain.widget.mpd()

return M



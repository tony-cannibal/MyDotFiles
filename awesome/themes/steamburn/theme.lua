---------------------------
local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local lain = require("lain")

local theme_path = os.getenv("HOME") .. "/.config/awesome/themes/steamburn/"

local theme = {}

theme.scripts = theme_path .. "scripts/"
theme.autostart = theme_path .. "autostart.sh"
theme.font          = "terminus 8"

theme.bg_systray    = theme.bg_normal
theme.bg_widget     = "#414b50"

theme.fg_normal                                 = "#e2ccb0"
theme.fg_focus                                  = "#d88166"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#140c0b"
theme.bg_focus                                  = "#140c0b"
theme.bg_urgent                                 = "#2a1f1e"
theme.border_normal                             = "#302627"
theme.border_focus                              = "#c2745b"
theme.border_marked                             = "#CC9393"
theme.taglist_fg_focus                          = "#140c0b"
theme.taglist_bg_focus                          = "#d88166"
theme.tasklist_bg_focus                         = "#140c0b"
theme.tasklist_fg_focus                         = "#d88166"

theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(8)
theme.border_width  = dpi(2)

-- Increase Default Width of Master Window
theme.master_width_factor = 0.55

-- Increase Space Between Tags
theme.taglist_spacing = 0

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.taglist_fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme_path.."titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_path.."titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme_path.."titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_path.."titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_path.."titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_path.."titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_path.."titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_path.."titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_path.."titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_path.."titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_path.."titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_path.."titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_path.."titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_path.."titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_path.."titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_path.."titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_path.."titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_path.."titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_path.."titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_path.."titlebar/maximized_focus_active.png"

theme.wallpaper = theme_path .. "wall.png"

theme.layout_txt_tile                           = "[T]"
theme.layout_txt_tileleft                       = "[l]"
theme.layout_txt_tilebottom                     = "[b]"
theme.layout_txt_tiletop                        = "[tt]"
theme.layout_txt_fairv                          = "[fv]"
theme.layout_txt_fairh                          = "[fh]"
theme.layout_txt_spiral                         = "[s]"
theme.layout_txt_dwindle                        = "[d]"
theme.layout_txt_max                            = "[M]"
theme.layout_txt_fullscreen                     = "[f]"
theme.layout_txt_magnifier                      = "[m]"
theme.layout_txt_floating                       = "[F]"

local markup = lain.util.markup
local gray   = "#7c7a75"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- {{{ Volume Widget
theme.volume, theme.vol_signal = awful.widget.watch("pamixer --get-volume-human", 60,
    function(widget, stdout)
            widget:set_markup(markup.font(theme.font,"[ " .. markup(gray,"Vol:") .. stdout))
    end)

theme.volume:buttons(gears.table.join(
    awful.button({}, 1, function()awful.spawn.with_line_callback(
            "pamixer -t", { exit =  function() theme.vol_signal:emit_signal("timeout") end}
            )end),
    awful.button({}, 4, function()awful.spawn.with_line_callback(
            "pamixer -i 5", { exit =  function() theme.vol_signal:emit_signal("timeout") end}
            )end),
    awful.button({}, 5, function()awful.spawn.with_line_callback(
            "pamixer -d 5", { exit =  function() theme.vol_signal:emit_signal("timeout") end}
            )end)
            ))

-- {{{ Mem Widget
theme.memory, theme.mem_signal = awful.widget.watch(theme.scripts .. "get-mem.sh", 2,
    function(widget, stdout)
        widget:set_markup(markup.font(theme.font, "[ " .. markup(gray, "Mem:") .. stdout))
    end)

-- {{{ Filesystem Widget
theme.space, theme.file_signal = awful.widget.watch(theme.scripts .. "get-space.sh", 2,
    function(widget, stdout)
        widget:set_markup(markup.font(theme.font, markup(gray, "[ /:") .. stdout))
    end)

theme.mpd = lain.widget.mpd({settings = function()
        local artist = mpd_now.artist
        local title = mpd_now.title
        if mpd_now.state == "play" then
            widget:set_markup(markup.font(theme.font, "[   " .. artist .. " - " .. title .. " ]"))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font,"[   " .. artist .. " - " .. title .. " ]"))
        elseif mpd_now.state == "stop" then
            widget:set_markup(markup.font(theme.font, "[ 栗 -- Stop -- ]"))
        else
            widget:set_markup("[Diconnected]")
        end
    end
})

theme.mpd.widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
        end)
    )
)

-- {{ Clock Widget
local mytextclock = wibox.widget.textclock("[ %I:%M %p ]")
mytextclock.font = theme.font
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Terminus 11",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

local net = lain.widget.net({
    settings = function()
        if net_now.state == "up" then net_state = "On" 
        else net_state = "Off" end
        widget:set_markup(markup.font(theme.font, "[" .. markup(gray, " Net:") .. net_state .. " ]"))
    end
})

-- CPU
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, "[" .. markup(gray, " Cpu:") .. cpu_now.usage .. "% ]"))
    end
})

local sep = wibox.widget.textbox(markup.font(theme.font, ' '))
local close = wibox.widget.textbox(markup.font(theme.font, ' ]'))


local function update_txt_layoutbox(s)
    -- Writes a string representation of the current layout in a textbox widget
    local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
    s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
    -- Wallpaper
    if theme.wallpaper then
        local wallpaper = theme.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end

    -- Each screen has its own tag table.
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    -- s.mylayoutbox = awful.widget.layoutbox(s)
    -- s.mylayoutbox:buttons(gears.table.join(
    --                        awful.button({ }, 1, function () awful.layout.inc( 1) end),
    --                        awful.button({ }, 3, function () awful.layout.inc(-1) end),
    --                        awful.button({ }, 4, function () awful.layout.inc( 1) end),
    --                        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- -- Text Layout Box Widget
    s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    awful.tag.attached_connect_signal(s, "property::selected", function () update_txt_layoutbox(s) end)
    awful.tag.attached_connect_signal(s, "property::layout", function () update_txt_layoutbox(s) end)
    s.mytxtlayoutbox:buttons(gears.table.join(
                           awful.button({}, 1, function() awful.layout.inc(1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc(1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
    -- Create a tasklist widget

    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18})

--     -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Seting this will center the middle widget
        -- expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            sep,
            s.mytaglist,
            sep,
            s.mytxtlayoutbox
        },
        -- s.mytasklist, -- Middle widget
            sep,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            theme.mpd.widget,
            sep,
            net.widget, 
            sep,
            cpu.widget,
            sep,
            theme.space,
            close,
            sep,
            theme.memory,
            close,
            sep,
            theme.volume,
            close,
            sep,
            mytextclock,
            wibox.widget.systray(),
            sep,
        },
    }
end


return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

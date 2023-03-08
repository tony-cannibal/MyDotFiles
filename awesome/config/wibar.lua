
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local my_table = gears.table -- 4.{0,1} compatibility

awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

screen.connect_signal("property::geometry", function(s)
-- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

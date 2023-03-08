pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- local wibox = require("wibox")
local beautiful = require("beautiful") -- Notification library
-- local naughty = require("naughty")
-- local menubar = require("menubar")
-- local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
require "config.error"

-- {{{ Variable definitions
local home_dir = os.getenv("HOME") .. "/.config/awesome/themes/"

local themes = {
    "everforest",      -- 1
    "everforest-alt",  -- 2
    "steamburn",       -- 3
    -- "gruvbox",
    -- "solarized",
    -- "catpuccin",
    -- "matrix"
}

awful.util.tagnames = { " 1 ", " 2 ", " 3 ", " 4 " , " 5 ", " 6 ", " 7 ", " 8 ", " 9 "}

-- This is used later as the default terminal and editor to run.

local chosen_theme = themes[1]
terminal = "wezterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

require "config.buttons"
beautiful.init(home_dir .. chosen_theme .. "/theme.lua")
-- Table of layouts to cover with awful.layout.inc, order matters.
require "config.layouts"
-- Menu
require "config.menu"
-- Wibar
require "config.wibar"
-- Key Bindings
require "config.keys"
-- Rules
require "config.rules"
-- Signals
require "config.signals"
-- Starup Script
do
    awful.spawn.with_shell(beautiful.autostart)
end

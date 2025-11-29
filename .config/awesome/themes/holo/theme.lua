--[[

     Holo Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears  = require("gears")
local lain   = require("lain")
local rubato = require("rubato")
local awful  = require("awful")
local wibox  = require("wibox")
local dpi    = require("beautiful.xresources").apply_dpi
--local shapes = require("nice.shapes")

local string, os = string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local catppuccin = require("colors/catppuccin")

local theme                                     = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.dpi = dpi
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/themes/holo/wall.png"
theme.font                                      = "Roboto Bold 10"
theme.little_font                               = "Roboto Bold 5"
theme.taglist_font                              = "Roboto Condensed Regular 10"
theme.fg_normal                                 = catppuccin.subtext0.hex
theme.fg_focus                                  = catppuccin.text.hex
theme.bg_focus                                  = catppuccin.mantle.hex
theme.bg_normal                                 = catppuccin.base.hex
theme.fg_urgent                                 = catppuccin.red.hex
theme.bg_urgent                                 = catppuccin.text.hex
theme.border_width                              = dpi(0.5)
theme.border_normal                             = "#00000000"
theme.border_focus                              = "#0099CC"
theme.taglist_fg_focus                          = catppuccin.mantle.hex
theme.tasklist_bg_normal                        = catppuccin.base.hex
theme.tasklist_fg_focus                         = catppuccin.text.hex
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(160)
theme.menu_icon_size                            = dpi(32)
theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/awesome_icon.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.mpdl                                      = theme.icon_dir .. "/mpd.png"
theme.mpd_on                                    = theme.icon_dir .. "/mpd_on.png"
theme.prev                                      = theme.icon_dir .. "/prev.png"
theme.nex                                       = theme.icon_dir .. "/next.png"
theme.stop                                      = theme.icon_dir .. "/stop.png"
theme.pause                                     = theme.icon_dir .. "/pause.png"
theme.play                                      = theme.icon_dir .. "/play.png"
theme.clock                                     = theme.icon_dir .. "/clock.png"
theme.calendar                                  = theme.icon_dir .. "/cal.png"
theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.net_up                                    = theme.icon_dir .. "/net_up.png"
theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(0)
theme.titlebar_close_button_normal              = theme.icon_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.icon_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.icon_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.icon_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.icon_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.icon_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.icon_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.icon_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.icon_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.icon_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.icon_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.icon_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.icon_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.icon_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.icon_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.icon_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.icon_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.icon_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.icon_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.icon_dir.."/titlebar/maximized_focus_active.png"

theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)



function theme.at_screen_connect(s)
    -- Quake application
    --s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    local topbar = require("widget/topbar")(s, theme)

end

return theme

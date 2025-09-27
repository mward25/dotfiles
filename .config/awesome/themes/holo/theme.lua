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

local catppuccin = {
    name = "macchiato",
    rosewater = {
        hex = "#f4dbd6",
        rgb = { 244, 219, 214 },
        hsl = { 10, 0.58, 0.90 },
    },
    flamingo = {
        hex = "#f0c6c6",
        rgb = { 240, 198, 198 },
        hsl = { 0, 0.58, 0.86 },
    },
    pink = {
        hex = "#f5bde6",
        rgb = { 245, 189, 230 },
        hsl = { 316, 0.74, 0.85 },
    },
    mauve = {
        hex = "#c6a0f6",
        rgb = { 198, 160, 246 },
        hsl = { 267, 0.83, 0.80 },
    },
    red = {
        hex = "#ed8796",
        rgb = { 237, 135, 150 },
        hsl = { 351, 0.74, 0.73 },
    },
    maroon = {
        hex = "#ee99a0",
        rgb = { 238, 153, 160 },
        hsl = { 355, 0.71, 0.77 },
    },
    peach = {
        hex = "#f5a97f",
        rgb = { 245, 169, 127 },
        hsl = { 21, 0.86, 0.73 },
    },
    yellow = {
        hex = "#eed49f",
        rgb = { 238, 212, 159 },
        hsl = { 40, 0.70, 0.78 },
    },
    green = {
        hex = "#a6da95",
        rgb = { 166, 218, 149 },
        hsl = { 105, 0.48, 0.72 },
    },
    teal = {
        hex = "#8bd5ca",
        rgb = { 139, 213, 202 },
        hsl = { 171, 0.47, 0.69 },
    },
    sky = {
        hex = "#91d7e3",
        rgb = { 145, 215, 227 },
        hsl = { 189, 0.59, 0.73 },
    },
    sapphire = {
        hex = "#7dc4e4",
        rgb = { 125, 196, 228 },
        hsl = { 199, 0.66, 0.69 },
    },
    blue = {
        hex = "#8aadf4",
        rgb = { 138, 173, 244 },
        hsl = { 220, 0.83, 0.75 },
    },
    lavender = {
        hex = "#b7bdf8",
        rgb = { 183, 189, 248 },
        hsl = { 234, 0.82, 0.85 },
    },
    text = {
        hex = "#cad3f5",
        rgb = { 202, 211, 245 },
        hsl = { 227, 0.68, 0.88 },
    },
    subtext1 = {
        hex = "#b8c0e0",
        rgb = { 184, 192, 224 },
        hsl = { 228, 0.39, 0.80 },
    },
    subtext0 = {
        hex = "#a5adcb",
        rgb = { 165, 173, 203 },
        hsl = { 227, 0.27, 0.72 },
    },
    overlay2 = {
        hex = "#939ab7",
        rgb = { 147, 154, 183 },
        hsl = { 228, 0.20, 0.65 },
    },
    overlay1 = {
        hex = "#8087a2",
        rgb = { 128, 135, 162 },
        hsl = { 228, 0.15, 0.57 },
    },
    overlay0 = {
        hex = "#6e738d",
        rgb = { 110, 115, 141 },
        hsl = { 230, 0.12, 0.49 },
    },
    surface2 = {
        hex = "#5b6078",
        rgb = { 91, 96, 120 },
        hsl = { 230, 0.14, 0.41 },
    },
    surface1 = {
        hex = "#494d64",
        rgb = { 73, 77, 100 },
        hsl = { 231, 0.16, 0.34 },
    },
    surface0 = {
        hex = "#363a4f",
        rgb = { 54, 58, 79 },
        hsl = { 230, 0.19, 0.26 },
    },
    base = {
        hex = "#24273a",
        rgb = { 36, 39, 58 },
        hsl = { 232, 0.23, 0.18 },
    },
    mantle = {
        hex = "#1e2030",
        rgb = { 30, 32, 48 },
        hsl = { 233, 0.23, 0.15 },
    },
    crust = {
        hex = "#181926",
        rgb = { 24, 25, 38 },
        hsl = { 236, 0.23, 0.12 },
    },
}

local theme                                     = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
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
theme.border_width                              = dpi(1.0)
theme.border_normal                             = "#252525"
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
theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"
theme.bar                                       = theme.icon_dir .. "/bar.png"
theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"
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

local markup = lain.util.markup
local blue   = "#80CCE6"
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup(theme.fg_normal, space3 .. "%H:%M   " .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font
--local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(mytextclock, theme.bg_normal, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(5), dpi(5))

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, theme.fg_normal, space3 .. "%d %b " .. markup.font("Roboto 5", " ")))
--local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(mytextcalendar, theme.tasklist_bg_normal, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, dpi(0), dpi(0), dpi(5), dpi(5))

local launcher_font_base = "Roboto Bold "
local launcher =  wibox.widget {
    widget = wibox.widget.textbox,
    --image   = beautiful.awesome_icon,
    font=launcher_font_base .. "18",
    markup=" ",
    buttons = awful.button({}, 0,
        function()
            awful.spawn("rofi -show drun &", false)
        end)
}

local launcher_bounce = rubato.timed {
    pos=18,
    duration = 1/2,
    intro = 1/6,
    override_dt = true,
    subscribed = function(pos) launcher.font = launcher_font_base .. pos end
}

launcher:connect_signal("button::press", function()
    --launcher.font = "Roboto Bold 14"
    launcher_bounce.target = 1
end)
launcher:connect_signal("button::release", function()
    --launcher.font = "Roboto Bold 18"
    launcher_bounce.target = 18
end)

-- Battery
local bat = lain.widget.bat({
    settings = function()
        bat_p      = bat_now.perc
        bat_icon = bat_p

        bat_p_num = tonumber(bat_p)
        if bat_p_num == nil then
            bat_icon = "󱠵"
        elseif bat_now.ac_status == 1 then
            if bat_p_num < 10 then
                bat_icon = "󰢜"
            elseif bat_p_num < 20 then
                bat_icon = "󰂆"
            elseif bat_p_num < 30 then
                bat_icon = "󰂇"
            elseif bat_p_num < 40 then
                bat_icon = "󰂈"
            elseif bat_p_num < 50 then
                bat_icon = "󰢝"
            elseif bat_p_num < 60 then
                bat_icon = "󰂉"
            elseif bat_p_num < 70 then
                bat_icon = "󰢞"
            elseif bat_p_num < 80 then
                bat_icon = "󰂊"
            elseif bat_p_num < 90 then
                bat_icon = "󰂋"
            else
                bat_icon = "󰂅"
            end
        else
            if bat_p_num < 10 then
                bat_icon = "󰁺"
            elseif bat_p_num < 20 then
                bat_icon = "󰁻"
            elseif bat_p_num < 30 then
                bat_icon = "󰁼"
            elseif bat_p_num < 40 then
                bat_icon = "󰁽"
            elseif bat_p_num < 50 then
                bat_icon = "󰁾"
            elseif bat_p_num < 60 then
                bat_icon = "󰁿"
            elseif bat_p_num < 70 then
                bat_icon = "󰂀"
            elseif bat_p_num < 80 then
                bat_icon = "󰂁"
            elseif bat_p_num < 90 then
                bat_icon = "󰂂"
            else
                bat_icon = "󰁹"
            end
        end
        widget:set_markup(markup.font(theme.font, markup(theme.fg_normal, bat_icon .. " ")))
    end
})

local volume_bar = wibox.widget {
    markup = "???",
    color = theme.fg_normal,
    background_color = theme.bg_focus,
    forced_height=dpi(1),
    forced_width=dpi(10),
    widget = wibox.widget.textbox,
}

local volume =  wibox.widget {
    widget = wibox.container.radialprogressbar,
    volume_bar
}

volume.min_value = 0
volume.max_value = 1
volume.value = 0.5
volume.forced_height = dpi(1)
volume.forced_width = dpi(50)
volume.color = theme.bg_focus
volume.border_color = theme.fg_focus
function update_volume_widget(volume_num, status, volume, volume_bar)

  print("volume_num: ", volume_num)
  print("Status: ", status)

  local volume_on = string.find(status, "on", 1, true)
  print("volume_on: ", volume_on)
  if not (volume_on == nil) then
      volume.value = 1.0-volume_num
  else
      volume.value = 1.0
  end

  local volume_icon = "󰕾"
  if volume_on == nil then
      volume_icon = ""
  elseif volume_num < 0.1 then
      volume_icon = "󰕿"
  elseif volume_num < 0.4 then
      volume_icon = "󰖀"
  elseif volume_num < 0.8 then
      volume_icon = "󰕾"
  end
  volume_icon = " " .. volume_icon .. "  "
  volume_bar:set_text(volume_icon .. volume_num*100 .. "  ")
end
local volume_status = "off"

local volume_bounce = rubato.timed {
    pos=0,
    duration = 1/2,
    intro = 1/6,
    override_dt = true,
    subscribed = function(pos) update_volume_widget(pos, volume_status, volume, volume_bar) end
}

function update_volume(volume_bounce)
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()

  local volume_num = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100
  -- volume = string.format("% 3d", volume)

  status = string.match(status, "%[(o[^%]]*)%]")

  volume_status = status

  if string.find(status, "on", 1, true)  == nil then
      volume_num = 0
  end

  volume_bounce.target = volume_num

end

gears.timer {
    timeout = 0.5,
    call_now = false,
    autostart = true,
    callback = function() update_volume(volume_bounce) end
}

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
local spr_left = wibox.widget.imagebox(theme.spr_left)
local bar = wibox.widget.imagebox(theme.bar)
local bottom_bar = wibox.widget.imagebox(theme.bottom_bar)

local barcolor  = gears.color({
    type  = "linear",
    from  = { dpi(32), 0 },
    to    = { dpi(32), dpi(32) },
    stops = { {0, theme.bg_focus}, {0.25, catppuccin.surface2.hex}, {1, theme.bg_focus} }
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
            screen = s, 
            filter = awful.widget.taglist.filter.all,
            buttons = awful.util.taglist_buttons, 
            style = {
                    bg_focus = barcolor 
            },
    }

    s.mytaglistcontainer = wibox.widget {
            {
                    s.mytaglist,
                    left=8,
                    right=8,
                    top=4,
                    bottom=4,
                    widget=wibox.container.margin,
            },
            bg = catppuccin.base.hex,
            shape = gears.shape.rounded_rect,
            shape_border_width = 1,
            shape_border_color = catppuccin.crust.hex,
            widget = wibox.container.background
    }

    -- mytaglistcont = wibox.container.background(
    --         s.mytaglist, 
    --         theme.bg_focus,
    --         gears.shape.rectangle)
    -- s.mytaglistcontainer = wibox.container.margin(mytaglistcont, dpi(0), dpi(0), dpi(0), dpi(0))
    --[[ local launcher_bounce = rubato.timed {
        pos=18,
        duration = 1/2,
        intro = 1/6,
        override_dt = true,
        subscribed = function(pos) launcher.font = launcher_font_base .. pos end
    } --]]

    -- Create a tasklist widget
-- Create a tasklist widget
    local tasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = awful.util.tasklist_buttons, 
        style = {
                shape             = gears.shape.rounded_rect,
                bg_normal         = theme.tasklist_bg_normal,
                fg_normal         = theme.tasklist_fg_normal,
                bg_focus          = theme.bg_focus,
                fg_focus          = theme.fg_focus,
                bg_minimize       = catppuccin.surface2.hex,
                fg_minimize       = catppuccin.surface1.hex,
                bg_urgent         = catppuccin.red.hex,
                fg_urgent         = catppuccin.blue.hex,
                shape_border_width = 1,
                shape_border_color = catppuccin.crust.hex,
        },
        widget_template = {
                {
                        {
                                id = 'clienticon',
                                widget = awful.widget.clienticon,
                        },
                        {
                                id = 'text_role',
                                widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal,
                },
                id = 'background_role',
                left = 5,
                right = 5,
                widget = wibox.container.background,
                create_callback = function(self, c, index, objects)
                        self:get_children_by_id('clienticon')[1].client = c
                end,
                update_callback = function(self, c)
                        self:get_children_by_id('clienticon')[1].client = c
                end

        }}
    s.mytasklist = tasklist
    -- s.mytasklist = wibox.widget {
    --         {
    --                 tasklist,
    --                 left=8,
    --                 right=8,
    --                 top=4,
    --                 bottom=4,
    --                 widget=wibox.container.margin,
    --         },
    --         bg = catppuccin.base.hex,
    --         shape = gears.shape.rounded_rect,
    --         shape_border_width = 1,
    --         shape_border_color = catppuccin.crust.hex,
    --         widget = wibox.container.background
    -- }
    -- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags,
    --     awful.util.tasklist_buttons, 
    --     {
    --             bg_focus = theme.bg_focus,
    --             shape = gears.shape.rectangle,
    --             shape_border_width = 5,
    --             shape_border_color = theme.tasklist_bg_normal, 
    --             align = "center" 
    --     })
    -- s.mytasklist = awful.widget.tasklist {
    --     screen  = s,
    --     filter  = awful.widget.tasklist.filter.currenttags,
    --     buttons = awful.util.tasklist_buttons,
    -- }
    -- s.mytasklist = awful.widget.tasklist {
    --         screen = s,
    --         filter = awful.widget.tasklist.filter.currenttags,
    --         buttons = awful.util.tasklist_buttons,
    --         layout = {
    --                 spacing = 5,
    --                 row_count = 1,
    --                 layout = wibox.layout.fixed.horizontal,
    --                 --bg_focus = theme.bg_focus,
    --                 --shape = gears.shape.rectangle,
    --                 --shape_border_width = 5,
    --                 --shape_border_color = theme.tasklist_bg_normal,
    --         },
    --         widget_template = {
    --             {
    --                 {
    --                     id     = "clienticon",
    --                     widget = awful.widget.clienticon,
    --                 },
    --                 margins = 4,
    --                 widget  = wibox.container.margin,
    --             },
    --             id              = "background_role",
    --             forced_width    = 48,
    --             forced_height   = 48,
    --             widget          = wibox.container.background,
    --             --[[anim = rubato.timed {
    --                  pos=18,
    --                  that = nil,
    --                  duration = 1/2,
    --                  intro = 1/6,
    --                  override_dt = true,
    --                  subscribed = function(pos)
    --                     local icon = that:get_children_by_id("clienticon")[1]
    --                      --awful.spawn("notify-send " .. pos) 
    --                  end
    --             },--]]
    --             create_callback = function(self, c, index, objects) --luacheck: no unused
    --                 self:get_children_by_id("clienticon")[1].client = c
    --                 --self.anim.that = self
    --             end,
    --             --[[update_callback=function(self, c, index, objects)
    --                 --self.anim.target = self.anim.target + 8
    --             end,--]]
    --         },
    --         border_color = "#777777",
    --         border_width = 2,
    --         ontop        = true,
    --         placement    = awful.placement.centered,
    --         shape        = gears.shape.rounded_rect,
    --         align        = "center"
    --
    --     }
    --


    -- Create the wibox
    s.mywibox = awful.wibar{
            position = "top",
            screen   = s,
            height   = dpi(32),
            shape    = gears.shape.rounded_bar,
            border_width = dpi(1),
            border_color = catppuccin.crust.hex,
        }

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            -- spr_small,
            -- spr_small,
            layout = wibox.layout.fixed.horizontal,
            -- launcher,
            -- spr_small,
            s.mytaglistcontainer,
            s.mypromptbox,
        },
        { -- Middle widget
            layout = wibox.layout.flex.horizontal,
            s.mytasklist
        },
        { -- Right widgets
            {
                {
                     layout = wibox.layout.fixed.horizontal,
                     wibox.widget.systray(),
                     calendarwidget,
                     clockwidget,
                     bat.widget,
                     volume,
                     s.mylayoutbox,
                     spr_small,
                     spr_small,
                },
                left=8,
                right=6,
                top=4,
                bottom=4,
                widget=wibox.container.margin,
            },
            bg = catppuccin.base.hex,
            shape = gears.shape.rounded_rect,
            shape_border_width = 1,
            shape_border_color = catppuccin.crust.hex,
            widget = wibox.container.background
        },
    }

    ---- Create the bottom wibox
    --s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = dpi(0), height = dpi(32) })
    --s.borderwibox = awful.wibar({ position = "bottom", screen = s, height = dpi(1), bg = theme.fg_focus, x = dpi(0), y = dpi(33)})

    ---- Add widgets to the bottom wibox
    --s.mybottomwibox:setup {
    --    layout = wibox.layout.align.horizontal,
    --    s.mytasklist, -- Left
    --    nil,
    --    { -- Right widgets
    --        layout = wibox.layout.fixed.horizontal,
    --        spr_bottom_right,
    --        --netdown_icon,
    --        --networkwidget,
    --        --netup_icon,
    --        --bottom_bar,
    --        --cpu_icon,
    --        --cpuwidget,
    --        layout = wibox.layout.fixed.horizontal,
    --        calendar_icon,
    --        calendarwidget,
    --        clock_icon,
    --        clockwidget,
    --        bat.widget,
    --        volume.widget

    --    },
    --}
end

return theme

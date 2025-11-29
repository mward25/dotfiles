-- @s = screen
return function(s, theme)
    local awful  = require("awful")
    local catppuccin = require("colors/catppuccin")
    local lain   = require("lain")
    local wibox  = require("wibox")
    local gears  = require("gears")

    local markup = lain.util.markup
    local space3 = markup.font("Roboto 3", " ")

    local dpi = theme.dpi

    -- Clock
    local mytextclock = wibox.widget.textclock(markup(theme.fg_normal, space3 .. "%H:%M   " .. markup.font("Roboto 4", " ")))
    mytextclock.font = theme.font
    --local clock_icon = wibox.widget.imagebox(theme.clock)
    local clockbg = wibox.container.background(mytextclock, theme.bg_normal, gears.shape.rectangle)
    local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(5), dpi(5))

    -- Calendar
    local calendar_widget = wibox.widget.textclock(markup.fontfg(theme.font, theme.fg_normal, space3 .. "%d %b " .. markup.font("Roboto 5", " ")))



    local bat = require("widget/bat")(theme)
    local volume = require("widget/volume")(theme)

    local barcolor  = gears.color({
        type  = "linear",
        from  = { dpi(32), 0 },
        to    = { dpi(32), dpi(32) },
        stops = { {0, theme.bg_focus}, {0.25, catppuccin.surface2.hex}, {1, theme.bg_focus} }
    })

    s.promptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(gears.table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
            screen = s, 
            filter = awful.widget.taglist.filter.all,
            buttons = awful.util.taglist_buttons, 
            style = {
                    bg_focus = barcolor 
            },
    }

    s.taglist_container = wibox.widget {
            {
                    s.taglist,
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

    -- Create the wibox
    s.topbar = awful.wibar{
            position = "top",
            screen   = s,
            height   = dpi(32),
            shape    = gears.shape.rounded_bar,
            border_width = dpi(1),
            border_color = catppuccin.crust.hex,
        }

    -- Add widgets to the wibox
    s.topbar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.taglist_container,
            s.promptbox,
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
                     calendar_widget,
                     clockwidget,
                     bat.widget,
                     volume,
                     s.layoutbox,
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
    return s.topbar
end

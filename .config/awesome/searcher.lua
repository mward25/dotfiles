local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")

local M = {}

local list_cols = 5
local list = wibox.widget {
    homogeneous   = true,
    spacing       = 5,
    min_cols_size = list_cols,
    min_rows_size = 10,
    layout        = wibox.layout.grid,
}

local last_row = 1

function add_row() 
    local row = wibox.widget {
        {
            widget = wibox.widget.textbox,
            text = tostring(last_row),
            align = "center",
            valign = "center",
        },
        widget = wibox.container.margin,
    }
    list:add(row)

    last_row = last_row + 1
end

for i = 1, 5 do
    add_row()
end

local popup = awful.popup {
    widget = list,
    border_color = '#00ff00',
    border_width = 5,
    placement = awful.placement.centered,
    shape = gears.shape.rounded_rect,
    visible = false,
    ontop = true,
}


function M.toggle()
    add_row()
    popup.visible = not popup.visible
end

return M

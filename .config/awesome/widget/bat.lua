local lain   = require("lain")
local markup = lain.util.markup

return function(theme) 
    return lain.widget.bat({
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
end

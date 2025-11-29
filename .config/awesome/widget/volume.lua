local gears  = require("gears")
local rubato = require("rubato")
local wibox  = require("wibox")
local dpi    = require("beautiful.xresources").apply_dpi

return function(theme)
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

    return volume
end

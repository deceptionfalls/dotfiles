local wibox = require('wibox')
local awful = require('awful')
local naughty = require("naughty")
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local bling = require('lib.bling')
local launcher = require('widgets.launcher')
local gettags = require('widgets.taglist')
local user = require('user')

local homeicon = wibox.widget {
    {
      {
        {
          image = beautiful.home,
          halign = "center",
          valign = "center",
          scaling_quality = 'nearest',
          widget = wibox.widget.imagebox
        },
        margins = dpi(9),
        widget = wibox.container.margin
      },
      align = "center",
      widget = wibox.container.place
    },
    bg = beautiful.bg2,
    widget  = wibox.container.background,
    buttons = {
      awful.button({}, 1, function()
        local app_launcher = bling.widget.app_launcher(launcher)
        app_launcher:toggle()
      end)
    },
}

local clock = wibox.widget {
    {
      {
        format = '<b>%I:%M</b>',
        valign = 'center',
        halign = 'center',
        widget = wibox.widget.textclock,
        font = user.font
      },
      left = dpi(9),
      right = dpi(9),
      bottom = dpi(0),
      top = dpi(0),
      widget = wibox.container.margin
    },
    fg = beautiful.fg3,
    bg = beautiful.bg2,
    widget = wibox.container.background,
}

local music = wibox.widget {
    {
      {
        {
          image = beautiful.music,
          halign = "center",
          valign = "center",
          scaling_quality = 'nearest',
          widget = wibox.widget.imagebox
        },
        margins = dpi(9),
        widget = wibox.container.margin
      },
      align = "center",
      widget = wibox.container.place
    },
    bg = beautiful.bg2,
    widget  = wibox.container.background,
    buttons = {
      awful.button({}, 1, function()
        awesome.emit_signal("music::toggle")
      end)
    },
}

local function status_widget()
    local status = wibox.widget {
        {
          {
            id = "image_role",
            align = "center",
            scaling_quality = 'nearest',
            widget = wibox.widget.imagebox
          },
          valign = "center",
          halign = "center",
          widget = wibox.container.place
        },
        forced_width = dpi(16),
        visible = true,
        widget = wibox.container.place,
        set_image = function(self, content)
            self:get_children_by_id('image_role')[1].image = content
        end
    }
    return status
end

bar_btn_net = status_widget()
bar_btn_bat = status_widget()
bar_btn_caps = status_widget()

local buttons = wibox.widget {
  {
    {
      bar_btn_bat,
      bar_btn_net,
      bar_btn_caps,
      spacing = dpi(-1),
      margins = dpi(0),
      layout = wibox.layout.fixed.horizontal
    },
    left = dpi(7),
    right = dpi(7),
    top = dpi(9),
    bottom = dpi(9),
    widget = wibox.container.margin
  },
  bg = beautiful.bg2,
  widget = wibox.container.background
}

screen.connect_signal("request::desktop_decoration", function(s)
    s.wibar = awful.wibar {
      position = "top",
      screen = s,
      height = dpi(30),
      border_width = dpi(6),
      border_color = beautiful.bg1,
      bg = beautiful.bg1,
      widget = {
        {
          homeicon,
          {
            {
              gettags(s),
              right   = dpi(4),
              left    = dpi(4),
              widget  = wibox.container.margin
            },
            bg = beautiful.bg2,
            widget = wibox.container.background
          },
          spacing = dpi(4),
          layout = wibox.layout.fixed.horizontal
        },
          nil,
          expand = "none",
        {
          clock,
          {
            buttons,
            layout  = wibox.layout.fixed.horizontal
          },
          music,
          spacing = dpi(4),
          layout  = wibox.layout.fixed.horizontal
        },
        layout  = wibox.layout.align.horizontal,
        margins = dpi(8),
        widget  = wibox.container.margin
      }
    }
end)

awesome.connect_signal("signal::network", function(is_enabled)
    bar_btn_net.image = is_enabled and beautiful.wifi or beautiful.nowifi
end)

awesome.connect_signal("signal::battery", function(value, state)
    bar_btn_bat.image = state and beautiful.battery_charge or beautiful.battery
end)

awesome.connect_signal("signal::capslock", function(status)
    if status then
      bar_btn_caps.image = beautiful.caps
      bar_btn_caps.visible = true

      -- Just to make sure
      naughty.notification {
        title = "Keyboard",
        text = "Caps Lock is On",
      }
    else
      bar_btn_caps.visible = false
    end
end)

-- Outer gaps
local screen = awful.screen.focused()
screen.padding = {
    right   = dpi(8),
    left    = dpi(8),
    bottom  = dpi(8),
    top     = dpi(8)
}

local awful = require('awful')
local wibox = require('wibox')
local ruled = require('ruled')
local naughty = require('naughty')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.border_width = 0
naughty.config.defaults.title = "Notification"

ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule = { urgency = 'critical' },
        properties = {
          bg = beautiful.bg1,
          fg = beautiful.fg3,
          font = beautiful.font,
          position = "top_right",
          spacing = dpi(2),
          timeout = 5
      }
    }
    ruled.notification.append_rule {
        rule = { urgency = 'normal' },
        properties = {
          bg = beautiful.bg1,
          fg = beautiful.fg3,
          font = beautiful.font,
          position = "top_right",
          spacing = dpi(2),
          timeout = 5
      }
    }
    ruled.notification.append_rule {
        rule = { urgency = 'low' },
        properties = {
          bg = beautiful.bg1,
          fg = beautiful.fg3,
          font = beautiful.font,
          position = "top_right",
          spacing = dpi(2),
          timeout = 5
      }
    }
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box {
    notification = n,
    type = "notification",
    bg = beautiful.bg1,
    widget_template = {
      {
        {
          {
            {
              {
                {
                  image = beautiful.heart,
                  halign = "center",
                  valign = "center",
                  scaling_quality = 'nearest',
                  layout = wibox.widget.imagebox
                },
                margins = dpi(13),
                widget = wibox.container.margin
              },
              bg = beautiful.bg2,
              widget = wibox.container.background
            },
            strategy = "min",
            width = dpi(40),
            widget = wibox.container.constraint
          },
          strategy = "max",
          width = dpi(40),
          widget = wibox.container.constraint
        },
        {
          {
            {
              {
                {
                  naughty.widget.title,
                  markup = "<b>text</b>",
                  widget = wibox.container.margin
                },
                naughty.widget.message,
                layout = wibox.layout.align.vertical,
                widget = wibox.container.margin
              },
              margins = dpi(10),
              widget = wibox.container.margin
            },
            strategy = "min",
            height = dpi(30),
            widget = wibox.container.constraint
          },
          strategy = "max",
          width = dpi(400),
          widget = wibox.container.constraint
        },
        layout = wibox.layout.align.horizontal
      },
      id = "background_role",
      widget = naughty.container.background,
    }
  }
end)

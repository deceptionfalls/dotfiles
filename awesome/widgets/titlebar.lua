local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local beautiful = require('beautiful')

client.connect_signal("request::titlebars", function(c)

    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

		controlstitle = wibox.widget {
			{
        {
          image = beautiful.maximize,
          halign = "center",
          valign = "center",
          scaling_quality = 'nearest',
          widget = wibox.widget.imagebox,
          buttons = {
            awful.button({ }, 1, function ()
              c.maximized = not c.maximized
              c:raise()
            end)
          },
        },
        {
          image = beautiful.close,
          halign = "center",
          valign = "center",
          scaling_quality = 'nearest',
          widget = wibox.widget.imagebox,
          buttons = {
            awful.button({ }, 1, function () c:kill() end)
          },
        },
				spacing = dpi(10),
				widget = wibox.layout.fixed.horizontal
			},
			right = dpi(12),
			top = dpi(12),
			bottom = dpi(12),
			widget = wibox.container.margin
		}

    awful.titlebar(c, { size = dpi(35) } ).widget = {
		{
			left = dpi(15),
			right = dpi(15),
			top = dpi(10),
			bottom = dpi(10),
			buttons = buttons,
			widget = wibox.container.margin
		},
		{
			buttons = buttons,
			widget = wibox.container.background
		},
		controlstitle,
        layout = wibox.layout.align.horizontal
    }
end)

local wibox = require('wibox')
local awful = require('awful')
local naughty = require("naughty")
local beautiful = require('beautiful')
local bling = require('lib.bling')
local launcher = require('widgets.launcher')
local gettags = require('widgets.taglist')
local dpi = beautiful.xresources.apply_dpi

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
        margins = dpi(8),
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

local layout = wibox.widget {
    {
      {
        {
          image = beautiful.layout_spiral,
          halign = "center",
          valign = "center",
          scaling_quality = 'nearest',
          widget = wibox.widget.imagebox
        },
        margins = dpi(8),
        widget = wibox.container.margin
      },
      align = "center",
      widget = wibox.container.place
    },
    bg = beautiful.bg2,
    widget  = wibox.container.background,
    -- buttons = {
    --   awful.button({}, 1, function()
    --   end)
    -- },
}

local clock = wibox.widget {
    {
      {
        format = '%I\n%M\n%p',
        valign = 'center',
        halign = 'center',
        widget = wibox.widget.textclock,
        font = beautiful.font
      },
      -- left = dpi(9),
      -- right = dpi(9),
      left = dpi(7),
      right = dpi(7),
      -- bottom = dpi(0), -- horizontal bar
      -- top = dpi(0), -- horizontal bar
      bottom = dpi(10),
      top = dpi(10),
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
        -- forced_width = dpi(16), -- horizontal bar
        forced_height = dpi(12), -- vertical bar
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
-- bar_btn_caps = status_widget()

local buttons = wibox.widget {
  {
    {
      bar_btn_bat,
      bar_btn_net,
      -- bar_btn_caps,
      -- spacing = dpi(-1), -- horizontal bar
      spacing = dpi(5),
      margins = dpi(0),
      -- layout = wibox.layout.fixed.horizontal -- horizontal bar
      layout = wibox.layout.fixed.vertical
    },
    left = dpi(8),
    right = dpi(8),
    -- top = dpi(9), -- horizontal bar
    -- bottom = dpi(9), -- horizontal bar
    top = dpi(10),
    bottom = dpi(8),
    widget = wibox.container.margin
  },
  bg = beautiful.bg2,
  widget = wibox.container.background
}

screen.connect_signal("request::desktop_decoration", function(s)
    s.wibar = awful.wibar {
      position = "left",
      screen = s,
      -- height = dpi(30), -- horizontal bar
      height = dpi(745), -- vertical bar
      width = dpi(30), -- vertical bar
      border_width = dpi(6),
      border_color = beautiful.bg1,
      bg = beautiful.bg1,
      widget = {
        {
          homeicon,
          -- spacing = dpi(4),
          layout = wibox.layout.fixed.vertical
        },
          {
            {
              gettags(s),
              -- dpi(4) for horizontal, dpi(3) for vertical
              right   = dpi(3),
              left    = dpi(3),
              widget  = wibox.container.margin
            },
            bg = beautiful.bg2,
            widget = wibox.container.background
          },
          expand = "none",
        {
          -- systray,
          {
            buttons,
            clock,
		      -- music,
            layout,
            spacing = dpi(-3),
            layout  = wibox.layout.fixed.vertical
          },
          spacing = dpi(4),
          layout  = wibox.layout.fixed.vertical
        },
        layout  = wibox.layout.align.vertical,
        margins = dpi(8),
        widget  = wibox.container.margin
      }
    }

   awful.placement.left(s.wibar, {margins = dpi(5)})

   s.wibar:struts({left = dpi(47)})

   -- Outer gaps, different from useless_gap from beautiful
   local screen = awful.screen.focused()
   screen.padding = dpi(3)
end)

-- Signals to update widgets
awesome.connect_signal("signal::network", function(is_enabled)
    bar_btn_net.image = is_enabled and beautiful.wifi or beautiful.nowifi
end)

awesome.connect_signal("signal::battery", function(value, state)
    bar_btn_bat.image = state and beautiful.battery_charge or beautiful.battery
end)

-- awesome.connect_signal("signal::capslock", function(status)
--     if status then
--       bar_btn_caps.image = beautiful.caps
--       bar_btn_caps.visible = true
--     else
--       bar_btn_caps.visible = false
--     end
-- end)

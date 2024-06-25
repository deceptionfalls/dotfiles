local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local playerctl = require("lib.bling").signal.playerctl.lib()
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

local album_art = wibox.widget{
    widget = wibox.widget.imagebox,
    image = beautiful.placeholder,
}

local song_artist = wibox.widget{
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText("Unknown", beautiful.fg2),
    font = beautiful.font,
    align = "left",
    valign = "center"
}

local song_name = wibox.widget{
    widget = wibox.widget.textbox,
    markup = helpers.colorizeText("None", beautiful.fg3),
    font = beautiful.font,
    align = "left",
    valign = "center"
}

local toggle_button = wibox.widget{
    widget = wibox.widget.imagebox,
    scaling_quality = 'nearest',
    image = beautiful.pause,
    forced_width = dpi(12),
    align = "center",
    valign = "center"
}

local next_button = wibox.widget{
    widget = wibox.widget.imagebox,
    image = beautiful.next,
    scaling_quality = 'nearest',
    forced_width = dpi(12),
    align = "center",
    valign = "center"
}

local prev_button = wibox.widget{
    widget = wibox.widget.imagebox,
    image = beautiful.prev,
    scaling_quality = 'nearest',
    forced_width = dpi(12),
    align = "center",
    valign = "center"
}

local toggle_command = function() playerctl:play_pause() end
local prev_command = function() playerctl:previous() end
local next_command = function() playerctl:next() end

toggle_button:buttons(gears.table.join(
    awful.button({}, 1, function() toggle_command() end)))

next_button:buttons(gears.table.join(
    awful.button({}, 1, function() next_command() end)))

prev_button:buttons(gears.table.join(
    awful.button({}, 1, function() prev_command() end)))

playerctl:connect_signal("metadata", function(_, title, artist, album_path, __, ___, ____)
	if title == "" then
		title = "None"
	end
	if artist == "" then
		artist = "Unknown"
	end
	if album_path == "" then
		album_path = beautiful.placeholder
	end

	album_art:set_image(gears.surface.load_uncached(album_path))
    song_name:set_markup_silently(helpers.colorizeText(title, beautiful.fg3))
	song_artist:set_markup_silently(helpers.colorizeText(artist, beautiful.fg2))

end)

playerctl:connect_signal("playback_status", function(_, playing, __)
	if playing then
        toggle_button.image = beautiful.pause
	else
        toggle_button.image = beautiful.play
	end
end)

local music_controls = wibox({
    ontop = true,
    visible = false,
    width = dpi(400),
    height = dpi(70),
    bg = beautiful.bg1,
})

music_controls:setup {
    {
      {
        album_art,
          {
            {
              nil,
                {
                  {
                    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                    widget = wibox.container.scroll.horizontal,
                    speed = 30,
                    song_name,
                    forced_width = dpi(220),
                  },
                  {
                    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                    widget = wibox.container.scroll.horizontal,
                    speed = 30,
                    song_artist,
                    forced_width = dpi(220),
                  },
                  layout = wibox.layout.fixed.vertical,
                },
              layout = wibox.layout.align.vertical,
              expand = "none"
            },
            {
              {
                {
                  prev_button,
                  {
                    {
                      {
                        toggle_button,
                        widget = wibox.container.margin,
                        margins = { top = dpi(5), bottom = dpi(5), right = dpi(7), left = dpi(7) }
                      },
                      widget = wibox.widget.background,
                      bg = beautiful.fg3
                    },
                    widget = wibox.container.margin,
                    margins = { top = dpi(12), bottom = dpi(12) }
                  },
                  next_button,
                  layout = wibox.layout.fixed.horizontal,
                  spacing = dpi(7)
                },
                widget = wibox.container.margin,
                margins = { left = dpi(12), right = dpi(12) }
              },
              forced_width = dpi(120),
              widget = wibox.widget.background,
              bg = beautiful.bg2
            },
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(15)
          },
          layout = wibox.layout.fixed.horizontal,
          spacing = dpi(6)
        },
      margins = dpi(10),
      widget = wibox.container.margin
    },
    widget = wibox.container.background,
}

awesome.connect_signal('music::toggle', function()
    music_controls.visible = not music_controls.visible
end)

awful.placement.top_right(music_controls, { margins = { right = dpi(8), top = dpi(10) }})

awful.keyboard.append_global_keybindings({
  awful.key(
  { "Mod4" }, "p", function ()
    awesome.emit_signal("music::toggle")
  end),
})

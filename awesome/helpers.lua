local _M = {}

local awful = require("awful")
local gears = require("gears")
local capi = { client = client, mouse = mouse }

function _M.move_client(c, direction)
	if c.floating or (awful.layout.get(capi.mouse.screen) == awful.layout.suit.floating) then
	  client.move_to_edge(c, direction)
	elseif awful.layout.get(capi.mouse.screen) == awful.layout.suit.max then
		if direction == "up" or direction == "left" then
			awful.client.swap.byidx(-1, c)
		elseif direction == "down" or direction == "right" then
			awful.client.swap.byidx(1, c)
		end
	else
		awful.client.swap.bydirection(direction, c, nil)
	end
end

function _M.centered_client_placement(c)
	return gears.timer.delayed_call(function()
		awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
	end)
end

_M.colorizeText = function(txt, fg)
  if fg == "" then
    fg = "#ffffff"
  end

  return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

return _M

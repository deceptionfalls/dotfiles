local awful = require("awful")
local user = require("user")

screen.connect_signal("request::desktop_decoration", function(s)
	tag.connect_signal("request::default_layouts", function()
    	awful.layout.append_default_layouts({
        -- If only awesome had good layouts, I miss you qtile <3
        -- awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.max,
    	})
	end)

    awful.tag(user.tags, s, awful.layout.layouts[1])
end)

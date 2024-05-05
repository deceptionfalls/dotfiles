local awful = require("awful")
local bling = require("lib.bling")
local mod = "Mod4"

-- Function to center the scratchpads
local function center(client)
    local screen = awful.screen.focused()
    local screen_geometry = screen.geometry

    local x = (screen_geometry.width - client.geometry.width) / 2
    local y = (screen_geometry.height - client.geometry.height) / 2

    client.geometry.x = x
    client.geometry.y = y

    client:toggle()
end

local term = bling.module.scratchpad {
    command = "st -c term -n term",
    rule = { instance = "term" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = { height=600, width=900 },
    reapply = true,
    dont_focus_before_close = true,
}

local ranger = bling.module.scratchpad {
    command = "st -c ranger -n ranger -e ranger",
    rule = { instance = "ranger" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = { height=600, width=900},
    reapply = true,
    dont_focus_before_close = true,
}

local alsamixer = bling.module.scratchpad {
    command = "st -c alsamixer -n alsamixer -e alsamixer",
    rule = { instance = "alsamixer" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = { height=600, width=900},
    reapply = true,
    dont_focus_before_close = true,
}

awful.keyboard.append_global_keybindings({
    awful.key({ mod }, "m", function() center(term) end),
    awful.key({ mod }, "b", function() center(ranger) end),
    awful.key({ mod }, "v", function() center(alsamixer) end),
})

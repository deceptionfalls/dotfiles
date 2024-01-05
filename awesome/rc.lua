pcall(require, "luarocks.loader")

local beautiful = require('beautiful')
local gfs = require('gears.filesystem')
local naughty = require('naughty')

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
      urgency = "critical",
      title = "An error occured"..(startup and " during startup!" or "!"),
      message = message
    }
end)

beautiful.init(gfs.get_configuration_dir() .. 'theme.lua')

require('user')
require('signals')
require('keybinds')
require('scratchpad')
require('autostart')
require('widgets')

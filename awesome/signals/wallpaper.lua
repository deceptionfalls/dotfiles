local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local user = require('user')

screen.connect_signal('request::wallpaper', function(s)
   -- If wallpaper is defined in user.lua, use it, else fallback
   -- to a solid color wallpaper.
   if user.wallpaper ~= nil then
      gears.wallpaper.maximized(user.wallpaper, s, false, nil)
   else
      awful.wallpaper {
         screen = s,
         widget = {
            widget = wibox.container.background,
            bg = beautiful.bg3,
          }
      }
   end
end)

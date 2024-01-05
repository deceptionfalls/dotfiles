local awful = require('awful')

client.connect_signal('manage', function(c)
  if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal('property::floating', function(c) c.ontop = c.floating end)
client.connect_signal('property::fullscreen', function(c) c:raise() end)

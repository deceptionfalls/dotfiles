local naughty = require('naughty')

awesome.connect_signal("signal::capslock", function(status)
    if status then
      naughty.notification {
        title = "Keyboard",
        text = "Caps Lock is On",
      }
    end
end)


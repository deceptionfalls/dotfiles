local awful = require('awful')
local gears = require('gears')
local user = require('user')

local battery_script = "bash -c 'echo $(cat /sys/class/power_supply/" .. user.battery .. "/capacity) echo $(cat /sys/class/power_supply/" .. user.battery .. "/status)'"

local function battery_emit()
  awful.spawn.easy_async_with_shell(
    battery_script, function(stdout)
    local level = string.match(stdout:match('(%d+)'), '(%d+)')
    local level_int = tonumber(level)
    local power = not stdout:match('Discharging')
    awesome.emit_signal('signal::battery', level_int, power)
  end)
end

gears.timer {
  timeout = 5,
  call_now = true,
  autostart = true,
  callback = function()
    battery_emit()
  end
}

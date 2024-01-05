local awful = require('awful')
local gears = require('gears')

local status_old = -1
local function emit_network_status()
  awful.spawn.easy_async_with_shell(
    "bash -c 'nmcli networking connectivity check'", function(stdout)
        local status = stdout:match("full")
        local status_id = status and 1 or 0
        if status_id ~= status_old then
            awesome.emit_signal('signal::network', status)
            status_old = status_id
        end
    end)
end

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        emit_network_status()
    end
}

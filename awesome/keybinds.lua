local awful = require("awful")
local bling = require("lib.bling")
local launcher = require("widgets.launcher")
local mod = "Mod4"

require("awful.autofocus")
require("signals.gunshot")

awful.keyboard.append_global_keybindings({
    awful.key(
      { mod }, "Return", function ()
        awful.spawn("st")
      end),

    awful.key(
      { mod, "Shift" }, "Return", function ()
          local app_launcher = bling.widget.app_launcher(launcher)
          app_launcher:toggle()
      end),

    awful.key(
      { mod, "Shift" }, "r",
        awesome.restart
      ),

    awful.key(
      { "Mod1" }, "Tab",
        awful.tag.viewnext
      ),

    awful.key(
      { "Mod1", "Shift" }, "Tab",
        awful.tag.viewprev
      ),

    awful.key(
      { mod }, "numrow", function(i)
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
      end),

    awful.key(
      { mod, "Shift" }, "numrow", function(i)
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
          end
        end),

    awful.key(
      { mod, "Shift" }, "j", function ()
        awful.client.swap.bydirection('down', client.swap)
      end),

    awful.key(
      { mod, "Shift" }, "k", function ()
        awful.client.swap.bydirection('up', client.swap)
      end),

    awful.key(
      { mod, "Shift" }, "h", function ()
        awful.client.swap.bydirection('left', client.swap)
      end),

    awful.key(
      { mod, "Shift" }, "l", function ()
        awful.client.swap.bydirection('right', client.swap)
      end),

    awful.key(
      { mod }, "Tab", function ()
        awful.layout.inc(1)
      end),

    awful.key(
      { mod, "Shift" }, "Tab", function ()
        awful.layout.inc(-1)
      end),

    awful.key(
      { mod }, "k", function ()
        awful.client.focus.byidx(-1)
      end),

    awful.key(
      { mod }, "j", function ()
        awful.client.focus.byidx(1)
      end),

    awful.key(
      { mod }, "h", function ()
        awful.client.focus.bydirection('left')
      end),

    awful.key(
      { mod }, "l", function ()
        awful.client.focus.bydirection('right')
      end),

    awful.key(
      { mod }, "w", function ()
        awful.spawn("firefox")
      end),

    awful.key(
      { mod }, "q", function ()
        awesome.emit_signal("screenshot::full")
      end),

    awful.key(
      { mod, "Shift" }, "q", function ()
        awesome.emit_signal("screenshot::part")
      end),

    awful.key(
      { nil }, "XF86AudioLowerVolume", function ()
        awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-")
      end),

    awful.key(
      { nil }, "XF86AudioRaiseVolume", function ()
        awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+")
      end),

    awful.key(
      { nil }, "XF86AudioMute", function ()
        awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
      end),

    awful.key(
      { mod }, "u", function ()
        awful.spawn.with_shell("playerctl --player=firefox previous")
      end),

    awful.key(
      { mod }, "i", function ()
        awful.spawn.with_shell("playerctl --player=firefox play-pause")
      end),

    awful.key(
      { mod }, "o", function ()
        awful.spawn.with_shell("playerctl --player=firefox next")
      end),
})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({

    awful.key(
      { mod }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end),

    awful.key(
      { mod }, "a", function(c)
        c.maximized = not c.maximized
        c:raise()
      end),

    awful.key(
      { mod, "Shift" }, "c", function(c)
        c:kill()
      end),

    awful.key(
      { mod }, "d", function(c)
        c.floating = not c.floating
				c:raise()
      end),

  })
end)

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { mod },
        keygroup    = "numrow",
        group       = "Tags",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end
    },
    awful.key {
        modifiers = { mod, "Shift" },
        keygroup    = "numrow",
        group       = "Tags",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end
    }
})

client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

awful.mouse.append_global_mousebindings({
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ mod }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ mod }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

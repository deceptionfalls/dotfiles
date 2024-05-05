local ruled = require("ruled")
local awful = require("awful")

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
      id = "global",
      rule = {},
      properties = {
        raise = true,
        size_hints_honor = false,
        screen = awful.screen.preferred,
        focus = awful.client.focus.filter,
        placement = function(c)
          awful.placement.centered(c, c.transient_for)
          awful.placement.no_overlap(c)
          awful.placement.no_offscreen(c)
        end,
      }
    }

    ruled.client.append_rule {
        id = "floating",
        rule_any = {
          instance = { "copyq", "pinentry" },
          class = { "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv", "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer", "feh", "qview", "ncmpcpp", "Places" },
          name = { "Event Tester" },
          role = { "AlarmWindow", "ConfigManager", "pop-up" }
        },
        properties = { floating = true }
    }

    ruled.client.append_rule {
        id = "titlebars",
        rule_any = { type = { "normal" } },
        properties = { titlebars_enabled = true },
    }

   ruled.client.append_rule {
      rule = { class = "obsidian" },
      properties = { titlebars_enabled = false },
   }
end)

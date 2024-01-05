local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi

local get_taglist = function(s)
  local mod = "Mod4"

    local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t) t:view_only() end),
        awful.button({mod}, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({mod}, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end),
        awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end),
        awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))

    local update_tags = function(self, c3)
        local tagicon = self:get_children_by_id('icon_role')[1]
        if c3.selected then
            tagicon.image = beautiful.heart_focus
        elseif #c3:clients() == 0 then
            tagicon.image = beautiful.heart_empty
          else
            tagicon.image = beautiful.heart
        end
    end

    local icon_taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {spacing = dpi(-6), layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {
                  id = 'icon_role',
                  scaling_quality = 'nearest',
                  widget = wibox.widget.imagebox
                },
                id = 'margin_role',
                top     = dpi(9),
                bottom  = dpi(9),
                left    = dpi(5),
                right   = dpi(5),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end,
            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
        buttons = taglist_buttons
    }
    return icon_taglist
end

return get_taglist

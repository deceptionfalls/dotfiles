local beautiful = require('beautiful')
local awful = require('awful')
local dpi = beautiful.xresources.apply_dpi

return {
    screen = awful.screen,
    placement = function(w)
        awful.placement.left(w, {
            honor_workarea = true,
            offset = {y = dpi(-81), x = dpi(6)}
        })
    end,
    reset_on_hide = false,
    save_history = true,
    wrap_page_scrolling = true, -- leave this in true because it fucking floods me with errors otherwise
    wrap_app_scrolling = true,
    border_color = beautiful.acc,
    background = beautiful.bg1,

    prompt_show_icon = false,
    prompt_icon = "",
    prompt_text_halign = "left",
    prompt_height = dpi(20),
    prompt_margins = dpi(10),
    prompt_paddings = dpi(5),
    prompt_color = beautiful.bg1,
    prompt_border_color = beautiful.bg1,
    prompt_icon_color = beautiful.bg1,
    prompt_text_color = beautiful.fg2,
    prompt_cursor_color = beautiful.fg2,
    prompt_icon_font =  beautiful.font,

    apps_per_row = 15,
    apps_per_column = 1,
    apps_spacing = dpi(0),
    apps_margin = dpi(0),
    app_width = dpi(300),
    app_height = dpi(30),
    app_name_halign = "left",
    app_name_valign = "center",
    app_show_icon = false,
    app_content_padding = dpi(10),
    app_content_spacing = dpi(0),
    app_name_font = beautiful.font,
    app_normal_color = beautiful.bg1,
    app_normal_hover_color = beautiful.bg2,
    app_selected_color = beautiful.bg2,
    app_selected_hover_color = beautiful.bg2,
    app_name_normal_color = beautiful.fg3,
    app_name_selected_color = beautiful.fg3,
}

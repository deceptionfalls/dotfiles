local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local gfs = require('gears.filesystem')
local path = gfs.get_configuration_dir() .. 'assets/'

local _T = {}

_T.bg1 = '#f2e9e1'
_T.bg2 = '#fffaf3'
_T.bg3 = '#faf4ed'
_T.fg1 = '#9893a5'
_T.fg2 = '#797593'
_T.fg3 = '#575279'

_T.acc = '#b4637a'
_T.acc2 = '#ea9d34'
_T.acc3 = '#286983'

_T.useless_gap = dpi(2)
_T.border_width = 0

_T.titlebar_bg_normal = _T.bg1
_T.titlebar_bg_focus = _T.bg2
_T.titlebar_bg_urgent = _T.acc
_T.titlebar_fg_normal = _T.fg1
_T.titlebar_fg_focus = _T.fg3
_T.titlebar_fg_urgent = _T.acc

_T.snap_border_width = dpi(2)
_T.snap_bg = _T.acc

_T.notification_spacing = dpi(8)

_T.home = gears.color.recolor_image(path .. 'home.png', _T.fg3)
_T.battery = gears.color.recolor_image(path .. 'battery_full.png', _T.fg3)
_T.battery_charge = gears.color.recolor_image(path .. 'battery_full_charging.png', _T.fg3)
_T.wifi = gears.color.recolor_image(path .. 'wifi.png', _T.fg3)
_T.nowifi = gears.color.recolor_image(path .. 'no_wifi.png', _T.fg3)
_T.heart = gears.color.recolor_image(path .. 'heart.png', _T.fg3)
_T.heart_focus = gears.color.recolor_image(path .. 'heart.png', _T.acc)
_T.heart_empty = gears.color.recolor_image(path .. 'heart_empty.png', _T.fg1)
_T.close = gears.color.recolor_image(path .. "close.png", _T.fg3)
_T.maximize = gears.color.recolor_image(path .. "maximize.png", _T.fg3)
_T.caps = gears.color.recolor_image(path .. "caps.png", _T.fg3)
_T.pause = gears.color.recolor_image(path .. "pause.png", _T.bg3)
_T.play = gears.color.recolor_image(path .. "play.png", _T.bg3)
_T.prev = gears.color.recolor_image(path .. "prev.png", _T.fg3)
_T.next = gears.color.recolor_image(path .. "next.png", _T.fg3)
_T.music = gears.color.recolor_image(path .. "music.png", _T.fg3)
_T.placeholder = gears.surface.load_uncached(path .. 'unix.png')

return _T

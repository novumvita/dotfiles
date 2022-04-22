--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi


local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}

theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/"
theme.wallpaper                                 = theme.confdir .. "/lain_wall.jpg"
theme.font                                      = "Terminus 10"
theme.menu_bg_normal                            = "#000000"
theme.menu_bg_focus                             = "#000000"
theme.bg_normal                                 = "#000000dd"
theme.bg_focus                                  = "#000000"
theme.bg_urgent                                 = "#000000"
theme.fg_normal                                 = "#ff3164bb"
theme.fg_focus                                  = "#ff3164"
theme.fg_urgent                                 = "#af1d18"
theme.fg_minimize                               = "#ffffff"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#606060"
theme.border_marked                             = "#3ca4d8"
theme.menu_border_width                         = 0
theme.menu_width                                = dpi(130)
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu.png"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = "#ff8c00"
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
-- theme.tasklist_plain_task_name                  = true
-- theme.tasklist_disable_icon                     = true
-- theme.useless_gap                               = 0
-- theme.layout_tile                               = theme.confdir .. "/icons/tile.png"
-- theme.layout_tilegaps                           = theme.confdir .. "/icons/tilegaps.png"
-- theme.layout_tileleft                           = theme.confdir .. "/icons/tileleft.png"
-- theme.layout_tilebottom                         = theme.confdir .. "/icons/tilebottom.png"
-- theme.layout_tiletop                            = theme.confdir .. "/icons/tiletop.png"
-- theme.layout_fairv                              = theme.confdir .. "/icons/fairv.png"
-- theme.layout_fairh                              = theme.confdir .. "/icons/fairh.png"
-- theme.layout_spiral                             = theme.confdir .. "/icons/spiral.png"
-- theme.layout_dwindle                            = theme.confdir .. "/icons/dwindle.png"
-- theme.layout_max                                = theme.confdir .. "/icons/max.png"
-- theme.layout_fullscreen                         = theme.confdir .. "/icons/fullscreen.png"
-- theme.layout_magnifier                          = theme.confdir .. "/icons/magnifier.png"
-- theme.layout_floating                           = theme.confdir .. "/icons/floating.png"

-- local icondir                    = gears.filesystem.get_configuration_dir() .. "icons/"
-- theme.widget_cpu                 = icondir .. "cpu.png"
-- theme.widget_mem                 = icondir .. "mem.png"
-- theme.widget_media               = {spotify = icondir .. "spoti.png", default = icondir .. "media.png"}
-- theme.widget_batt                = icondir .. "bat.png"
-- theme.widget_clock               = icondir .. "clock.png"
-- theme.widget_vol                 = icondir .. "spkr.png"
-- theme.widget_brightness          = icondir .. "brightness.png"
-- theme.widget_net                 = {icondir.."wifi_bar_0.png", icondir.."wifi_bar_1.png", icondir.."wifi_bar_2.png", icondir.."wifi_bar_3.png", icondir.."wifi_bar_4.png"} 

-- theme.font                       = "JetBrainsMono 9"
-- theme.hotkeys_font               = "sans-serif bold 9"
-- theme.hotkeys_description_font   = "sans-serif 9"

-- theme.hotkeys_modifiers_fg       = "#dddddd"
-- theme.hotkeys_fg                 = "#cccccc"

-- theme.bg_normal                  = "#101010"
-- theme.bg_focus                   = "#000000"
-- theme.bg_urgent                  = "#000000"
-- theme.fg_normal                  = "#aaaaaa"
-- theme.fg_focus                   = "#ff8c00"
-- theme.fg_urgent                  = "#af1d18"
-- theme.fg_minimize                = "#ffffff"

-- theme.bg_wibar                   = "#000000aa"

-- theme.border_width               = 3
-- theme.border_focus               = "#32a2a8"
-- theme.border_normal              = "#00000000"
-- theme.border_marked              = theme.border_normal

-- theme.menu_font                  = "sans-serif 12"
-- theme.menu_bg_normal             = "#101010"
-- theme.menu_bg_focus              = "#444444"
-- theme.menu_border_width          = 5
-- theme.menu_border_color          = "#00000000"
-- theme.menu_fg_normal             = "#dddddd"
-- theme.menu_fg_focus              = theme.menu_fg_normal

local icondir                    = gears.filesystem.get_configuration_dir() .. "icons/"
theme.widget_cpu                 = icondir .. "cpu.png"
theme.widget_mem                 = icondir .. "mem.png"
theme.widget_media               = {spotify = icondir .. "spoti.png", default = icondir .. "media.svg"}
theme.widget_batt                = icondir .. "battery.svg"
theme.widget_clock               = icondir .. "clock.png"
theme.widget_vol                 = {icondir .. "audio-volume-high.svg", icondir .. "audio-volume-muted.svg"} 
theme.widget_brightness          = icondir .. "brightness.svg"
theme.widget_net                 = {icondir.."wifi_bar_0.png", icondir.."wifi_bar_1.png", icondir.."wifi_bar_2.png", icondir.."wifi_bar_3.png", icondir.."wifi_bar_4.png"} 

theme.widget_icon_gap            = 8
theme.widget_gap                 = 15
theme.bg_systray                 = "#181818"
theme.systray_icon_spacing       = 5

theme.menu_launcher              = icondir .. "arch.png"
theme.menu_lock_icon             = icondir .. "lock.svg" 
theme.menu_logout_icon           = icondir .. "log-out.svg"
theme.menu_reboot_icon           = icondir .. "refresh-cw.svg"
theme.menu_power_icon            = icondir .. "power.svg"

theme.minimise_def_icon          = icondir .. "music.svg"

-- theme.taglist_font               = "sans-serif semi-bold italic 10"
-- theme.taglist_bg_focus           = "#00000000"
-- theme.taglist_bg_urgent          = "#00000000"
-- theme.taglist_fg_focus           = "#42adf0"
-- theme.taglist_fg_occupied        = "#a6a6a6"
-- theme.taglist_fg_urgent          = theme.taglist_fg_occupied
-- theme.taglist_fg_empty           = "#555555"

-- theme.tasklist_bg_normal         = "#00000000"
-- theme.tasklist_disable_task_name = true
-- theme.tasklist_plain_task_name   = true
-- theme.tasklist_bg_normal         = "#dddddd"
-- theme.useless_gap                = 4

-- theme.notification_font          = "sans-serif 9"
-- theme.notification_bg            = "#303030"
-- theme.notification_fg            = "#fafafa"
-- theme.notification_shape         = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 5) end
-- theme.notification_border_color  = theme.notification_fg
-- theme.notification_max_height    = 200
-- theme.notification_max_width     = 500
-- theme.notification_icon_size     = 100

local markup = lain.util.markup

-- Textclock
-- os.setlocale(os.getenv("LANG")) -- to localize the clock
-- local clockicon = wibox.widget.imagebox(theme.widget_clock)
-- local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#ab7367", ">") .. markup("#de5e1e", " %H:%M "))
-- mytextclock.font = theme.font
-- -- -- Calendar
-- theme.cal = lain.widget.cal({
--     attach_to = { mytextclock },
--     notification_preset = {
--         font = "Terminus 10",
--         fg   = theme.fg_normal,
--         bg   = theme.bg_normal
--     }
-- })

-- Weather
--[[ to be set before use
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = { font = "Terminus 10", fg = theme.fg_normal },
    weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
    settings = function()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°C "))
    end
})
--]]

-- / fs
--[[ commented because it needs Gio/Glib >= 2.54
local fsicon = wibox.widget.imagebox(theme.widget_fs)
theme.fs = lain.widget.fs({
    notification_preset = { font = "Terminus 10", fg = theme.fg_normal },
    settings  = function()
        widget:set_markup(markup.fontfg(theme.font, "#80d9d8", string.format("%.1f", fs_now["/"].used) .. "% "))
    end
})
--]]

-- Mail IMAP check
--[[ to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})
--]]

-- -- CPU
-- local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
-- local cpu = lain.widget.cpu({
--     settings = function()
--         widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
--     end
-- })

-- -- Coretemp
-- local tempicon = wibox.widget.imagebox(theme.widget_temp)
-- local temp = lain.widget.temp({
--     settings = function()
--         widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
--     end
-- })

-- -- Battery
-- local baticon = wibox.widget.imagebox(theme.widget_batt)
-- local bat = lain.widget.bat({
--     settings = function()
--         local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

--         if bat_now.ac_status == 1 then
--             perc = perc .. " plug"
--         end

--         widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
--     end
-- })

-- ALSA volume
-- local volicon = wibox.widget.imagebox(theme.widget_vol)
-- theme.volume = lain.widget.alsa({
--     settings = function()
--         if volume_now.status == "off" then
--             volume_now.level = volume_now.level .. "M"
--         end

--         widget:set_markup(markup.fontfg(theme.font, "#7493d2", volume_now.level .. "% "))
--     end
-- })

-- Net
-- local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
-- local netdowninfo = wibox.widget.textbox()
-- local netupicon = wibox.widget.imagebox(theme.widget_netup)
-- local netupinfo = lain.widget.net({
--     settings = function()
--         --[[ uncomment if using the weather widget
--         if iface ~= "network off" and
--            string.match(theme.weather.widget.text, "N/A")
--         then
--             theme.weather.update()
--         end
--         --]]

--         widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
--         netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
--     end
-- })

-- MEM
-- local memicon = wibox.widget.imagebox(theme.widget_mem)
-- local memory = lain.widget.mem({
--     settings = function()
--         widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
--     end
-- })

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(theme.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            --mpdicon:set_image() -- not working in 4.0
            mpdicon._private.image = nil
            mpdicon:emit_signal("widget::redraw_needed")
            mpdicon:emit_signal("widget::layout_changed")
        end
        widget:set_markup(markup.fontfg(theme.font, "#e54c62", artist) .. markup.fontfg(theme.font, "#b2b2b2", title))
    end
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    -- s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(19), bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    -- s.mywibox:setup {
    --     layout = wibox.layout.align.horizontal,
    --     { -- Left widgets
    --         layout = wibox.layout.fixed.horizontal,
    --         logout_menu_widget(),
    --         --s.mylayoutbox,
    --         s.mytaglist,
    --         s.mypromptbox,
    --         mpdicon,
    --         theme.mpd.widget,
    --     },
    --     -- s.mytasklist, -- Middle widget
    --     nil,
    --     { -- Right widgets
    --         layout = wibox.layout.fixed.horizontal,
    --         -- wibox.widget.systray(),
    --         -- media_widget(),
    --         --mailicon,
    --         --theme.mail.widget,
    --         -- netdownicon,
    --         -- netdowninfo,
    --         -- netupicon,
    --         -- netupinfo.widget,
    --         -- volicon,
    --         -- brightness_widget{
    --         --     type = 'icon_and_text',
    --         --     program = 'brightnessctl',
    --         --     step = 2,        
    --         --     font = "Terminus 9"
    --         -- }, 
    --         -- volume_widget{
    --         --     widget_type = 'arc'
    --         -- },
    --         -- theme.volume.widget,
    --         -- memicon,
    --         -- memory.widget,
    --         -- cpuicon,
    --         -- cpu.widget,
    --         -- battery_widget(),
    --         -- fsicon,
    --         --theme.fs.widget,
    --         --weathericon,
    --         --theme.weather.widget,
    --         -- tempicon,
    --         -- temp.widget,
    --         -- baticon,
    --         -- bat.widget,
    --         -- clockicon,
    --         mytextclock,
    --     },
    -- }
    s.mywibox = require("bar")

    -- Create the bottom wibox
--     s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

--     -- Add widgets to the bottom wibox
--     s.mybottomwibox:setup {
--         layout = wibox.layout.align.horizontal,
--         { -- Left widgets
--             layout = wibox.layout.fixed.horizontal,
--         },
--         s.mytasklist, -- Middle widget
--         { -- Right widgets
--             layout = wibox.layout.fixed.horizontal,
--             s.mylayoutbox,
--         },
--     }
end

return theme

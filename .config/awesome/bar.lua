local gears = require("gears")
local lain_widget  = require("widgets.lain.widget")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local markup = require("widgets.lain.markup")
local lain = require("lain")
local theme = require("theme")

local media_widget = require("widgets.media")
-- local volume_widget = require("widgets.volume-widget.volume")
local volume_widget = require("widgets.pipewire")
local wifi_widget = require("widgets.wifi")
local brightness_widget = require("widgets.brightness")

local menu_bg = function(cr, w, h) gears.shape.rectangle(cr, w, h) end
-- [[[ Main Menu
local mymainmenu = awful.menu({
	items = {
		{"lock", "slock", beautiful.menu_lock_icon},
		{"log out", function() awesome.quit() end, beautiful.menu_logout_icon},
		{"reboot", "reboot", beautiful.menu_reboot_icon},
		{"power off", "shutdown now", beautiful.menu_power_icon},
	},
	theme = {
		height = 38,
		width = 140
	}
})
mymainmenu.wibox.shape = menu_bg

local menulauncher = wibox.widget.imagebox(beautiful.menu_launcher);
menulauncher:connect_signal("button::press", function(_, _, _, button) mymainmenu:show({coords = {x = 0, y = 0}}) end)

-- Hide the menu when the mouse leaves it
local mouse_in_main = false
-- when mouse leaves launcher icon without entering menu. close it
menulauncher:connect_signal("mouse::leave", function()
		if mymainmenu.wibox.visible then
			gears.timer{
				timeout = 0.1,
				autostart = true,
				callback = function () if not mouse_in_main then mymainmenu:hide() end end,
				single_shot = true
			}
		end
	end
)
mymainmenu.wibox:connect_signal("mouse::enter", function() mouse_in_main = true end)
mymainmenu.wibox:connect_signal("mouse::leave", function() 
		mymainmenu:hide()
		mouse_in_main = false
	end
)
-- ]]]


-- [[[ Middle Box
local mouse_in_client_menu = false
local client_menu = nil
	
local on_middlebar_mouse_button = function(_, _, _, button)
	if button == 3 then
		-- if not currently visible
		if(client_menu == nil) then
			local client_list = {}
			local max_len = 5			--biggest width. to set appropriate size for menu

			for _, c in ipairs(client.get()) do
				table.insert(client_list, {c.class, function() c:jump_to(false) end})
				max_len = math.max(max_len, #c.class)
			end
			if #client_list == 0 then return end

			table.sort(client_list, function(a, b) return a[1] < b[1] end)

			client_menu = awful.menu({
				items=client_list,
				theme={font = "sans-serif 11", height = #client_list + 20, width = max_len*13 + 10}
			})
			client_menu.wibox.shape = menu_bg
			client_menu.wibox:connect_signal("mouse::enter", function() mouse_in_client_menu = true end)
			client_menu.wibox:connect_signal("mouse::leave", function() 
					client_menu:hide()
					client_menu = nil
					mouse_in_client_menu = false
				end
			)
			client_menu:show()
		
		else
			client_menu:hide()
			client_menu = nil
		end	
	end
end

local on_middlebar_mouse_leave = function()
	if client_menu ~= nil then
		gears.timer{
			timeout = 0.1,
			single_shot = true,
			autostart = true,
			callback = function () 
				if not mouse_in_client_menu then 
					client_menu:hide()
					client_menu = nil
				end
			end,
		}
	end
end
-- ]]]


-- [[[Taglist //tasklist
local taglist_buttons = gears.table.join(
	-- move to tag on clicking the title
	awful.button({}, 1, function(t) t:view_only() end),
	-- move focused window to clicked tag
	awful.button({modkey}, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end
	),
	-- adds focused window to the clicked tag also
	awful.button({modkey}, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end
	),
	-- moves between tags on scroll wheel
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5,	function(t)	awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	-- unminimise window
	awful.button({}, 1, function(c)	c.minimized = false end)
)

-- ]]]

-- [[[ Widgets

-- Textclock
local clock_color = "#ff3c88"
local mytextclock = wibox.widget.textclock(markup(clock_color, "%a %d %b") .. markup(clock_color, " > ") .. markup(clock_color, "%I:%M %p"));
-- mytextclock.font = beautiful.font
local clock_widget = wibox.widget {
	widget = wibox.layout.fixed.horizontal,
	spacing = beautiful.widget_icon_gap,
	-- wibox.widget.imagebox(beautiful.widget_clock),
	mytextclock
}

-- Calendar
local cal_task = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Terminus 10",
        -- fg   = theme.fg_normal,
		fg = "#aaaaaa",
        bg   = theme.bg_normal
    }
})

-- CPU
local cpu_widget = {
	widget = wibox.layout.fixed.horizontal,
	spacing = beautiful.widget_icon_gap,
	wibox.widget.imagebox(beautiful.widget_cpu),
	lain_widget.cpu({settings = function() 
		widget:set_markup(markup.fontfg(beautiful.font, "#776bfd", cpu_now.usage .. "%"))
	end}).widget,
}

-- Battery
local battery_widget = wibox.widget {
	widget = wibox.layout.fixed.horizontal,
	spacing = beautiful.widget_icon_gap,
	wibox.widget.imagebox(beautiful.widget_batt),
	lain_widget.bat({settings = function()
		local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or "..."

		if bat_now.ac_status == 1 then
			perc = perc .. " A/C"
		end

		widget:set_markup(markup.fontfg(beautiful.font, "#ff3c88", perc))
	end
})}

battery_widget:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		awful.spawn("xfce4-power-manager -c");
		return
	elseif button == 3 then
		awful.spawn.with_shell("alacritty -e htop");
	end;
end
);

-- MEM
local memory_widget = {
	widget = wibox.layout.fixed.horizontal,
	spacing = beautiful.widget_icon_gap,
	wibox.widget.imagebox(beautiful.widget_mem),
	lain_widget.mem({settings = function() widget:set_markup(markup.fontfg(beautiful.font, "#6b96fd", mem_now.used .. "M")) end}).widget,
}

-- Systray Container
local mysystray = wibox.container.margin(wibox.widget.systray(), 0, beautiful.systray_icon_spacing, 4, 4)

-- Media Widget
local my_media_widget = media_widget({icons = beautiful.widget_media, font = beautiful.font, space = beautiful.widget_icon_gap, color = "#ff3164"})

-- Volume Widget
local my_volume_widget = volume_widget({icon = beautiful.widget_vol, font = beautiful.font, space = beautiful.widget_icon_gap, color = "#ff3164"})

-- Wifi Widget
local my_wifi_widget = wifi_widget({icons = beautiful.widget_net, font = beautiful.font, space = beautiful.widget_icon_gap})

-- Brightness Widget
local my_brightness_widget = brightness_widget({icon = beautiful.widget_brightness, font = beautiful.font, space = beautiful.widget_icon_gap, color = "#ff3164"})

-- ]]]


function generate_wibar(s)
	-- layout indicator
	-- s.mylayoutbox = awful.widget.layoutbox(s)
	-- s.mylayoutbox:buttons(gears.table.join(
	-- 	awful.button({}, 1, function() awful.layout.inc(1) end),
	-- 	awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
	-- 	awful.button({}, 3, function() awful.layout.inc(-1) end)
	-- ))

	s.mytaglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	}

	s.mytasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.minimizedcurrenttags,
		buttons = tasklist_buttons,
		layout   = {
			spacing = 5,
			layout  = wibox.layout.fixed.horizontal
    },
		widget_template = {
			id     = 'icon_role',
			widget = wibox.widget.imagebox,
			image = beautiful.minimise_def_icon			-- default icon for apps without icon(looking at you, Spotify)
		}
	}
	
	local my_middle_widget = wibox.container.place(
		wibox.container.margin(s.mytasklist, 7, 10, 5, 5),
		"left"
	)
	my_middle_widget.fill_horizontal = true
	my_middle_widget:connect_signal("button::press", on_middlebar_mouse_button);
	my_middle_widget:connect_signal("mouse::leave", on_middlebar_mouse_leave);

	s.mywibar = awful.wibar({ position = "top", screen = s, bg = beautiful.bg_wibar, fg = beautiful.fg_normal})

	s.mywibar:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			menulauncher,
			s.mytaglist,
			-- s.mylayoutbox,
			-- {
			-- 	widget = wibox.widget.separator,
			-- 	span_ratio = 0.65,
			-- 	color = beautiful.fg_normal,
			-- 	orientation = 'vertical',
			-- 	forced_width= 20
			-- },
		},
		my_middle_widget,
		{	-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = beautiful.widget_gap,
			-- spacing_widget = {
			-- 	widget = wibox.widget.separator,
			-- 	span_ratio = 0.65,
			-- 	color = beautiful.fg_normal,
			-- },
			my_media_widget,
			-- s.index == 1 and memory_widget or nil,
			-- s.index == 1 and cpu_widget or nil,
			my_volume_widget,
			s.index == 1 and my_brightness_widget or nil,
			battery_widget,

			-- my_wifi_widget,
			clock_widget,
			s.index == 1 and mysystray or nil,
		},
	}
end

return generate_wibar;
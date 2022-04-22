-------------------------------------------------
-- Speaker Volume Widget for Pipewire-Pulse
-- Also toggles noisetorch
-------------------------------------------------

local awful = require("awful");
local wibox = require("wibox");
local watch = require("awful.widget.watch");

local GET_SINK_VOL_CMD = "pactl get-sink-volume @DEFAULT_SINK@";
-- local GET_SOURCE_VOL_CMD = "pactl get-source-volume @DEFAULT_SOURCE@";
local NOISETORCH_CMD = "pactl get-source-volume \'NoiseTorch Microphone\'"

local UPDATE_CMD = string.format("bash -c \"%s && %s\"", GET_SINK_VOL_CMD, NOISETORCH_CMD)

local MUTE_CMD = "pactl get-sink-mute @DEFAULT_SINK@"

local volume_widget = {}

local worker = function(user_args)

	local args = user_args or {}

	local icons = args.icon;
	local font = args.font or "sans-serif 9";
	local timeout = 1;
	local color = args.color or "#ffffff"
	
	volume_widget = wibox.widget{
		layout = wibox.layout.fixed.horizontal,
		spacing = args.space,
		{
			id = "icon",
			widget = wibox.widget.imagebox,
			image = icons[1]
		},
		{
			id = "volume",
			font = font,
			widget = wibox.widget.textbox
		},

		update_volume = function(self, volume, is_noisetorch)
			
			local volume_text = string.format("%s%s", volume, is_noisetorch and " N" or "");
			local volume_markup = string.format("<span font='%s' foreground='%s'>%s</span>", font, color, volume_text);

			if self.volume:get_markup() ~= volume_markup then
				self.volume:set_markup(volume_markup);
			end
		end
	}

	local update_widget = function(widget, stdout, stderr, _, _)
		local is_noisetorch = stderr == ''
		local vol_left, vol_right = string.match(stdout, "/ *(%S+)");
		-- if album ~= nil and title ~= nil and artist ~= nil then
			widget:update_volume(vol_left, is_noisetorch);
		-- end;
	end;

	local update_icon = function(widget, stdout, stderr, _, _)
		is_muted = string.match(stdout, "[^Mute: ]");
		widget.icon.image = (is_muted == "y" and icons[2] or icons[1])
		widget:emit_signal('widget::redraw_needed')
	end,

	watch(UPDATE_CMD, timeout, update_widget, volume_widget);
	watch(MUTE_CMD, timeout, update_icon, volume_widget)

	--- Adds mouse controls to the widget:
	--  - left click - pavucontrol
	--  - right click - toggle mute
	--  - scroll up - volume up
	--  - scroll down - volume down
	--  - middle click - start noisetorch
	volume_widget:connect_signal("button::press", function(_, _, _, button)
			if button == 1 then
				awful.spawn("pavucontrol");
				return
				
			elseif button == 4 then
				awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%", false);
				
			elseif button == 5 then
				awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false);
				
			elseif button == 3 then
				awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false);

			elseif button == 2 then
				awful.spawn.easy_async(NOISETORCH_CMD, function(_, stderr, _, _)
						awful.spawn("noisetorch -" .. (stderr=="" and "u" or "i"), false)
					end
				)
			end;
			awful.spawn.easy_async(UPDATE_CMD, function(stdout, stderr, _, _) update_widget(volume_widget, stdout, stderr) end)
		end
	);

	return volume_widget;
end;

return setmetatable(volume_widget, {	__call = function(_, ...)
		return worker(...);
	end
});
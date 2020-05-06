------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- gears
local gears = require "gears"

-- table utils
require "utils.table"

---------------
-- variables --
---------------

VOLUME_CHECK_COMPLETED = true
LAST_VOLUME_STATUS = {}

------------
-- volume --
------------

local update_volume_is_set = function(volume)
	local cmd = [[amixer sget Master | tail -1 | awk -F" " '{print $6}' | sed 's/\[//g' | sed 's/\]//g']]

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitreason, exitcode)
			local volume_toggled_str = string.gsub(stdout, "\n*$", "")

			if (volume_toggled_str == "on") then
				volume.toggled = true
			else
				volume.toggled = false
			end

			if not table_equals(LAST_VOLUME_STATUS, volume) then
				LAST_VOLUME_STATUS = volume
				awesome.emit_signal("volume::updated", volume)
			end

			VOLUME_CHECK_COMPLETED = true
		end
	)
end

local update_volume_height = function()
	local cmd = [[amixer sget Master | tail -1 | awk -F" " '{print $4}' | sed 's/\[//g' | sed 's/\]//g']]

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitreason, exitcode)
			local volume = {}

			volume.height = string.gsub(stdout, "\n*$", "")

			update_volume_is_set(volume)
		end
	)
end

gears.timer {
	autostart = true,
	call_now = true,
	timeout = 1,
	callback = function()
		if (VOLUME_CHECK_COMPLETED) then
			VOLUME_CHECK_COMPLETED = false
			update_volume_height()
		end
	end
}

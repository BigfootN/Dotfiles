------------------
-- load modules --
------------------

-- gears
local gears = require "gears"

-----------------
-- timed popup --
-----------------

function create_timed_popup(popup, hide_sec)
	local ret = {}

	ret.popup = popup
	ret.timer = nil 

	return ret
end

function display_timed_popup(timed_popup)
	timed_popup.popup.visible = true

	if timed_popup.timer == nil then
		timed_popup.timer = gears.timer.start_new(8,
			function()
				timed_popup.popup.visible = false
				return false
			end
		)
	else
		timed_popup.timer:again()
	end
end

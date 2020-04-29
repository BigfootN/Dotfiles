------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- theme
local theme = require "theme"

-- gears
local gears = require "gears"

-- calculations
local calcs = require "utils.calculations"

-- wibox
local wibox = require "wibox"

-- wibox
local progress_bar = require "widgets.popup_volume.popup_volume_progress_bar_widget"

-- icon
local icon = require "widgets.popup_volume.popup_volume_icon_widget"

----------------------
-- global variables --
----------------------

DISPLAY_POPUP = false

------------------
-- popup create --
------------------

local popup_volume = awful.popup {
	border_width = theme.popup_volume_border_width,
	border_color = theme.popup_volume_border_color,
	ontop = true,
	visible = false,
	bg = theme.popup_volume_bg,
	widget = wibox.container.background
}

-----------------
-- popup setup --
-----------------

popup_volume:setup {
	{
		icon,
		progress_bar,
		spacing = 15,
		layout = wibox.layout.fixed.horizontal
	},
	margins = 15,
	widget = wibox.container.margin
}

---------------------
-- popup placement --
---------------------

popup_volume.placement = nil
awful.placement.bottom_right(popup_volume, {
		margins = {
			right = calcs.popup_volume_offset_right,
			bottom = calcs.popup_volume_offset_bottom
		}
})

------------------------
-- create timed popup --
------------------------

local timed_popup = create_timed_popup(popup_volume, 1)

------------------
-- update popup --
------------------

awesome.connect_signal("volume::updated",
	function(volume)
		if DISPLAY_POPUP then
			local volume_str = string.gsub(volume.height, "%%", "")
			local volume_int = tonumber(volume_str)

			progress_bar.value = volume_int

			if not volume.toggled then
				popup_volume_set_icon(" ")
			end

			display_timed_popup(timed_popup)
		else
			DISPLAY_POPUP = true
		end
	end
)

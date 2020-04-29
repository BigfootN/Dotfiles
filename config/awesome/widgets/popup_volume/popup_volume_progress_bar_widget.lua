------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- wibox
local wibox = require "wibox"

-- theme
local theme = require "theme"

-- calcs
local calcs = require "utils.calculations"

-- gears
local gears = require "gears"

-------------------------------
-- popup volume progress bar --
-------------------------------

local popup_volume_progress_bar = wibox.widget {
	max_value = 100,
	value = 53,
	forced_height = 10,
	forced_width = calcs.popup_volume_progress_bar_width,
	background_color = theme.popup_volume_progress_bar_bg,
	color = theme.popup_volume_progress_bar_fg,
	bar_border_color = nil,
	border_color = nil,
	shape = gears.shape.rounded_bar,
	clip = true,
	widget = wibox.widget.progressbar
}

return popup_volume_progress_bar

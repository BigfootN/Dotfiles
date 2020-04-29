------------------
-- load modules --
------------------

-- local
local test = require "awful"

-- wibox
local wibox = require "wibox"

-- theme
local theme = require "theme"

------------------------------
-- popup volume icon widget --
------------------------------

local icon_widget = wibox.widget {
	text = " ",
	font = "UbuntuCondensed Nerd Font 15",
	widget = wibox.widget.textbox
}

local popup_volume_icon_widget = wibox.widget {
	icon_widget,
	fg = theme.popup_volume_progress_bar_fg,
	bg = theme.popup_volume_bg,
	widget = wibox.container.background
}

function popup_volume_set_icon(icon)
	icon_widget.text = icon
end

return popup_volume_icon_widget

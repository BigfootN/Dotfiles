------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- environmental variables
local vars = require "utils.env_variables"

-- beautiful
local theme = require "theme"

---------------
-- functions --
---------------

-- calculate screen height percentage
function percentage_screen_height(height_perc)
	local height_pixel = screen[1].geometry.height
	local ret = 0

	ret = (height_perc * height_pixel) / 100

	return ret
end

-- calculate screen width percentage
function percentage_screen_width(width_perc)
	local width_pixel = screen[1].geometry.width
	local ret = 0

	ret = (width_perc * width_pixel) / 100

	return ret
end

-- percentage of a number
function percentage_number(perc, number)
	local ret = 0

	ret = (perc * number) / 100

	return ret
end

-- get tagnames only
function tagnames()
	local table = {}

	for k, v in ipairs(theme.taglist) do
		table.insert(table, v.icon)
	end

	return table
end

----------
-- math --
----------

local calc = {
	-- screen padding
	screen_padding_top = math.floor(percentage_screen_height(theme.screen_padding_top_perc)),
	screen_padding_bottom = math.floor(percentage_screen_width(theme.screen_padding_bottom_perc)),
	screen_padding_right = math.floor(percentage_screen_width(theme.screen_padding_right_perc)),
	screen_padding_left = math.floor(percentage_screen_width(theme.screen_padding_left_perc)),

	-- bar geometry
	bar_width = screen[1].geometry.width,
	bar_height = math.floor(percentage_screen_height(theme.bar_height_perc))
}

-- bar underline height
calc.bar_underline_height = math.floor(percentage_number(theme.bar_underline_height_perc, calc.bar_height))

-- bar single tag width
calc.bar_single_tag_width = math.floor(percentage_screen_width(theme.bar_single_tag_width_perc))

-- popup music height
calc.popup_music_height = 2*theme.popup_music_margin_metadata + 2*theme.popup_music_text_gap + 3*theme.popup_music_text_height

-- popup music cover height
calc.popup_music_cover_height = calc.popup_music_height - 2*theme.popup_music_margin_cover

-- popup volume progress bar width
calc.popup_volume_progress_bar_width = percentage_screen_width(theme.popup_volume_progress_bar_width_perc)

-- popup volume offset
calc.popup_volume_offset_right = percentage_screen_width(theme.popup_volume_offset_right_perc)
calc.popup_volume_offset_bottom = percentage_screen_height(theme.popup_volume_offset_bottom_perc)

-- popup volume offset
calc.popup_music_offset_right = percentage_screen_width(theme.popup_music_offset_right_perc)
calc.popup_music_offset_top = percentage_screen_height(theme.popup_music_offset_top_perc)

return calc

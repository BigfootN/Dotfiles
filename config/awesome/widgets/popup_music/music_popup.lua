------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- text
local music_text = require "widgets.popup_music.music_text"

-- cover
local music_cover = require "widgets.popup_music.music_cover"

-- calc
local calc = require "utils.calculations"

-- beautiful
local theme = require "theme"

-- gears
local gears = require "gears"

-- wibox
local wibox = require "wibox"

-- signals
require "events.music"

-- timed popup
require "widgets.timed_popup"

-----------
-- popup --
-----------

local popup_music = awful.popup {
	visible = false,
	placement = awful.placement.top_right,
	border_width = theme.popup_music_border_width,
	border_color = theme.popup_music_border_color,
	ontop = true,
	type = "notification",
	widget = wibox.container.background,
	height = calc.popup_music_height
}

----------------------
-- set popup layout --
----------------------

popup_music:setup {
	music_text.music_text_playing_widget,
	music_cover.music_playing_cover_widget,
	layout = wibox.layout.fixed.horizontal
}

-----------------------
-- set popup buttons --
-----------------------

popup_music:buttons({
	awful.button({},
		1,
		function (c)
			c.visible = false
		end)
})

------------------------
-- create timed popup --
------------------------

local timed_popup = create_timed_popup(popup_music, 8)

------------------------
-- check music events --
------------------------

awesome.connect_signal("music::changed",
	function(music, cover_image_surface)
		local artist_textbox = music_text.artist_textbox
		local album_textbox = music_text.album_textbox
		local title_textbox = music_text.title_textbox
		local cover_imagebox = music_cover.cover_imagebox

		popup_music.visible = false

		artist_textbox.text = music.artist
		album_textbox.text = music.album
		title_textbox.text = music.title
		cover_imagebox.image = cover_image_surface

		popup_music.placement = nil
		awful.placement.top_right(popup_music, {
			margins = {
				top = calc.popup_music_offset_top,
				right = calc.popup_music_offset_right
			}
		})

		display_timed_popup(timed_popup)
	end
)

------------------
-- return popup --
------------------

return popup_music

------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- wibox
local wibox = require "wibox"

-- theme
local theme = require "theme"

-------------------------
-- create music module --
-------------------------

local music_module = bar_module_create({
	icon_color = theme.bar_module_music_color,
	spacing = 10
})

-------------------------
-- update music widget --
-------------------------

awesome.connect_signal("music::changed",
	function(music)
		if music.status == "playing" then
			bar_module_update_display(music_module, "ﱘ", music.artist..[[ - ]]..music.title)
		else
			bar_module_update_display(music_module, "", music.artist..[[ - ]]..music.title)
		end
	end
)

awesome.connect_signal("music::stopped",
	function()
		bar_module_update_display(music_module, "", "")
	end
)

return music_module.widget

------------------
-- load modules --
------------------

-- wibox
local wibox = require "wibox"

-- theme
local theme = require "theme"

-- calcs
local calcs = require "utils.calculations"

------------------------
-- widget music cover --
------------------------

local cover_imagebox = wibox.widget {
    id = 'cover',
    resize = true,
    forced_height = calcs.popup_music_cover_height,
    forced_width = calcs.popup_music_cover_height,
    widget = wibox.widget.imagebox
}

local music_playing_cover_widget = wibox.widget {
    {
        cover_imagebox,
        margins = theme.popup_music_margin_cover,
        widget = wibox.container.margin
    },
    bg = theme.popup_music_bg,
    forced_height = calcs.popup_music_height,
    forced_width = calcs.popup_music_height,
    widget = wibox.container.background
}

return {
    music_playing_cover_widget = music_playing_cover_widget,
    cover_imagebox = cover_imagebox
}
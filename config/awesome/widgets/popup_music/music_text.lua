------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- wibox
local wibox = require "wibox"

-- vars
local vars = require "utils.env_variables"

-- theme
local theme = require "theme"

-- utils
local utils = require "utils"

--------------------------
-- music playing widget --
--------------------------

local create_textbox = function(id_textbox)
    local ret = wibox.widget {
        id = id_textbox,
        font = theme.widget_music_playing_font,
        align = "right",
        valign = "center",
        forced_height = theme.popup_music_text_height,
        widget = wibox.widget.textbox
    }

    return ret
end

-- title textbox
local title_textbox = create_textbox("title")

-- album textbox
local album_textbox = create_textbox("album")

-- artist textbox
local artist_textbox = create_textbox("artist")

local music_text_playing_widget = wibox.widget {
    {
        {
            {
                title_textbox,
                layout = wibox.layout.fixed.horizontal
            },
            {
                album_textbox,
                layout = wibox.layout.fixed.horizontal
            },
            {
                artist_textbox,
                layout = wibox.layout.fixed.horizontal
            },
            spacing = theme.popup_music_text_gap,
            layout = wibox.layout.fixed.vertical
        },
        margins = theme.popup_music_margin_metadata,
        widget = wibox.container.margin,
    },
    bg = theme.popup_music_bg,
    fg = theme.widget_music_playing_font_color,
    widget = wibox.container.background
}

---------------------
-- return textboxs --
---------------------

return {
    music_text_playing_widget = music_text_playing_widget,
    artist_textbox = artist_textbox,
    album_textbox = album_textbox,
    title_textbox = title_textbox
}
------------------
-- load modules --
------------------

-- env_vars
local env_variables = require "utils.env_variables"

-- gears
local gears = require "gears"

-------------------
-- theme settins --
-------------------

-- bar bg
local bar_bg = "#2d2d2d"

-- default colors
local tag_fg_default = "#928374"
local tag_bg_default = bar_bg

local tag_names = {
	TAG_BROWSER_NAME_ICON = "ﯱ",
	TAG_CODE_NAME_ICON = "",
	TAG_TERMINAL_NAME_ICON = "",
	TAG_FILE_NAME_ICON = "",
	TAG_MUSIC_NAME_ICON = "",
	TAG_TORRENT_NAME_ICON = ""
}

-- theme array
local theme = {

	-- tagnames
	tag_names = tag_names,

	-- tagnames
	taglist = {
		{
			name = "browser",
			icon = tag_names.TAG_BROWSER_NAME_ICON
		},
		{
			name = "code",
			icon = tag_names.TAG_CODE_NAME_ICON
		},
		{
			name = "terminal",
			icon = tag_names.TAG_TERMINAL_NAME_ICON
		},
		{
			name = "file",
			icon = tag_names.TAG_FILE_NAME_ICON
		},
		{
			name = "music",
			icon = tag_names.TAG_MUSIC_NAME_ICON
		},
		{
			name = "torrent",
			icon = tag_names.TAG_TORRENT_NAME_ICON
		}
	},

	-- number of tags
	nb_tagnames = 6,

	-- wallpaper path
	wallpaper = env_variables.home.."/.wallpaper/wall.jpg",

	-- top bar geometry (percentage)
	bar_height_perc = 4,

	-- bar bg
	bar_bg = bar_bg,

	-- bar font
	bar_font = "RobotoMono Nerd Font 13",
	bar_font_color = "#928374",

	-- bar taglist font
	bar_taglist_font = "UbuntuCondensed Nerd Font 15",

	-- underline height (percentage)
	bar_underline_height_perc = 9,

	-- bar underline color
	bar_underline_color = "#af3a03",

	-- bar radius
	bar_radius = 0,

	-- tag width
	bar_single_tag_width_perc = 3,

	-- bar modules color
	bar_module_time_color = "#cc241d",
	bar_module_date_color = "#98971a",
	bar_module_ssid_color = "#d79921",
	bar_module_updates_color = "#458588",
	bar_module_music_color = "#689d6a",
	bar_module_volume_color = "#d65d0e",

	-- bar module label color
	bar_module_label_color = "#928374",

	-- bar module font
	bar_module_icon_font = "UbuntuCondensed Nerd Font 15",
	bar_module_label_font = "UbuntuCondensed Nerd Font 14",

	-- taglist colors
	tag_fg = "#928374",
	tag_bg = tag_bg_default,
	tag_fg_focus = "#af3a03",
	tag_bg_focus = tag_fg_default,
	tag_fg_volatile = tag_fg_default,
	tag_bg_volatile = tag_bg_default,
	tag_fg_occupied = tag_fg_default,
	tag_bg_occupied = tag_bg_default,
	tag_fg_empty = tag_fg_default,
	tag_bg_empty = tag_bg_default,
	tag_underline_color = tag_fg_default,
	tag_underline_focused_color = "#af3a03",

	-- padding under bar (percentage)
	screen_padding_top_perc = 1.5,
	screen_padding_bottom_perc = 1.2,
	screen_padding_left_perc = 1.5,
	screen_padding_right_perc = 1.5,

	-- client border color
	client_border_color = "#928374",
	client_focused_border_color = "#cc241d",

	-- client border shape
	client_shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 0)
	end,

	-- client border
	client_border_width = 5,

	-- gaps between clients
	gap_between_clients = 10,

	-- music playing widget
	widget_music_playing_font = "UbuntuCondensed Nerd Font 13",
	widget_music_playing_font_color = "#504945",

	-- popup music border
	popup_music_border_width = 2,
	popup_music_border_color = "#cc241d",

	-- popup music metadata (title, album, artist) text height
	popup_music_text_height = 20,

	-- popup music gap between metadata (title, album, artist)
	popup_music_text_gap = 8,

	-- popup music margin around whole metadata (title, album, artist)
	popup_music_margin_metadata = 8,

	-- popup music padding cover
	popup_music_margin_cover = 10,

	-- popup music offset (perc)
	popup_music_offset_top_perc = 5,
	popup_music_offset_right_perc = 1.2,

	-- popup volume offset (perc)
	popup_volume_offset_bottom_perc = 2,
	popup_volume_offset_right_perc = 1.2,

	-- popup music colors
	popup_music_bg = "#d5c4a1",
	popup_music_fg = "#665c54",

	-- popup music visible time
	popup_music_visible_time_s = 5,

	-- popup volume colors
	popup_volume_bg = "#d5c4a1",
	popup_volume_progress_bar_bg = "#928374",
	popup_volume_progress_bar_fg = "#458588",
	popup_volume_border_color = "#cc241d",

	-- popup volume border width
	popup_volume_border_width = 2,

	-- popup volume size (perc)
	popup_volume_progress_bar_width_perc = 15,

	-- time timezone
	time_timezone = "Europe/Paris"
}

------------------
-- return theme --
------------------

return theme

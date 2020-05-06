--------------------
-- load modules --
--------------------

-- wibar
local awful = require "awful"

-- wibox
local wibox = require "wibox"

-- gears
local gears = require "gears"

-- environmental variables
local env_variables = require "utils.env_variables"

-- theme
local theme = require "theme"

-- utils
local calcs = require "utils.calculations"

-- time
local modules = require "bar.modules"

---------------------
-- button taglists --
---------------------

local wbuttons = {
	awful.button({}, 1,
		function(t)
			t:view_only()
		end
	)
}

-------------------------
-- tag widget template --
-------------------------

-- template declaration
local bar_widget_template = {
	{
		{
			id = 'text_role',
			valign = "center",
			align = "center",
			font = theme.bar_taglist_font,
			forced_height = calcs.bar_height,
			forced_width = calcs.bar_single_tag_width,
			widget = wibox.widget.textbox
		},
		id = "background_role",
		forced_height = calcs.bar_height,
		forced_width = calcs.bar_single_tag_width,
		widget = wibox.container.background
	},
	layout = wibox.layout.fixed.horizontal
}

--------------------
-- taglist layout --
--------------------

local bar_taglist_layout = {
	spacing = 0,
	fill_space = true,
	layout = wibox.layout.fixed.horizontal
}

--------------------
-- taglist widget --
--------------------

local taglist = awful.widget.taglist {
	screen = screen[1],
	filter = awful.widget.taglist.filter.all,
	buttons = wbuttons,
	widget_template = bar_widget_template,
	layout = bar_taglist_layout,
	style = {
		fg_focus = theme.tag_fg_focus,
		bg_focus = theme.tag_bg_focus,
		fg_urgent = theme.tag_fg_urgent,
		bg_urgent = theme.tag_bg_urgent,
		fg_empty = theme.tag_fg_empty,
		bg_empty = theme.tag_bg_empty,
		fg_occupied = theme.tag_fg_occupied,
		bg_occupied = theme.tag_bg_occupied,
		fg_volatile = theme.tag_fg_volatile,
		bg_volatile = theme.tag_bg_volatile
	}
}

--------------
-- bar init --
--------------

local bar = awful.wibar ({
	position = 'top',
	type = "dock",
	screen = screen[1],
	width = calcs.bar_width,
	height = calcs.bar_height + calcs.bar_underline_height,
	bg = theme.bar_bg,
	shape = gears.shape.rectangle
})

------------------------
-- wibar layout setup --
------------------------

bar:setup {
	{
		{
			taglist,
			modules.center,
			{
				nil,
				nil,
				modules.right,
				expand = "inside",
				layout = wibox.layout.align.horizontal
			},
			spacing = 0,
			expand = "outside",
			layout = wibox.layout.align.horizontal
		},
		right = 15,
		widget = wibox.container.margin
	},
	{
		forced_height = calcs.bar_underline_height,
		forced_width = calcs.bar_width,
		bg = theme.bar_underline_color,
		widget = wibox.container.background
	},
	layout = wibox.layout.fixed.vertical
}

------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- theme
local theme = require "theme"

----------
-- tags --
----------

-- default layout
local default_layout = awful.layout.suit.fair

-- init tags
awful.screen.connect_for_each_screen(
	function(s)
		awful.tag({}, s, default_layout)

		for k, v in pairs(theme.taglist) do
			awful.tag.add(
				v.icon,
				{
					gap_single_client = true,
					gap = theme.gap_between_clients,
					layout = default_layout
				}
				)
		end

		s.tags[1]:view_only()
	end
	)

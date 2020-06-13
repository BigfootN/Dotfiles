------------------
-- load modules --
------------------

-- theme
local theme = require "theme"

-------------
-- signals --
-------------

client.connect_signal("request::activate",
	function(c)
		c.border_color = theme.client_focused_border_color
	end
)

client.connect_signal("request::autoactivate",
	function(c)
		c.border_color = theme.client_focused_border_color
	end
)

client.connect_signal("unfocus",
	function(c)
		c.border_color = theme.client_border_color
	end
)

client.connect_signal("request::manage",
	function(c)
		c:activate()
	end
)

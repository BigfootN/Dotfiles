------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

---------------------------
-- focus client on click --
---------------------------

client.connect_signal("request::default_mousebindings",
	function()
		awful.mouse.append_client_mousebindings({
			awful.button({}, 1,
				function(c)
					c:activate()
				end
			)
		})
	end
)

------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- ruled
local ruled = require "ruled"

-- theme
local theme = require "theme"

-- apps
local apps = require "settings.apps"

-----------
-- rules --
-----------
ruled.client.connect_signal("request::rules",
	function()
		ruled.client.append_rule {
			rule = {},
			properties = {
				shape = theme.client_shape,
				border_width = theme.client_border_width,
				size_hints_honor = false,
				focus = true
			}
		}

		ruled.client.append_rule {
			rule = {
				type = "dialog"
			},
			properties = {
				placement = awful.placement.centered
			}
		}

		for _, app in pairs(apps) do
			if (type(app) ~= "function") and app.ruled then
				ruled.client.append_rule {
					rule = {
						instance = app.instance
					},
					properties = {
						tag = app.tag,
						switch_to_tags = true
					}
				}
			end
		end
	end
)

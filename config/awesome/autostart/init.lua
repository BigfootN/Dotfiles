------------------
-- load modules --
------------------

-- progs
local apps = require "settings.apps"

-- autostart
require "autostart.autostart"

for _, app in pairs(apps) do
	if (type(app) ~= "function") and (app.autostart == true) then
		autostart(app)
	end
end

------------------
-- load modules --
------------------

-- time
local time = require "bar.modules.time"

-- date
local date = require "bar.modules.date"

-- updates
local updates = require "bar.modules.number_updates"

-- volume
local volume = require "bar.modules.volume"

-- music
local music = require "bar.modules.music"

-- wibox
local wibox = require "wibox"

----------------------------
-- modules left and right --
----------------------------

local modules_right = wibox.widget {
	volume,
	updates,
	date,
	time,
	spacing = 15,
	layout = wibox.layout.fixed.horizontal
}

local modules_center = wibox.widget {
	music,
	layout = wibox.layout.fixed.horizontal
}

-----------------
-- all modules --
-----------------

local modules = {
	center = modules_center,
	right = modules_right
}

return modules

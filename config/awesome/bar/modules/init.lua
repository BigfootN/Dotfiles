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

-- wibox
local wibox = require "wibox"

-------------
-- modules --
-------------

local modules = wibox.widget {
    volume,
    updates,
    date,
    time,
    spacing = 15,
    layout = wibox.layout.fixed.horizontal
}

return modules
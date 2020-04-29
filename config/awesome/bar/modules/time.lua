------------------
-- load modules --
------------------

-- theme
local theme = require "theme"

-- module
require "bar.module"

-- time event
require "events.time"

-----------------
-- time module --
-----------------

local time_module = bar_module_create({
    icon = "",
    icon_color = theme.bar_module_time_color
})

-------------------------
-- update textbox time --
-------------------------

awesome.connect_signal("time::updated",
    function(time)
        bar_module_update_display(time_module, "", time)
    end
)

-------------------
-- return widget --
-------------------

return time_module.widget
------------------
-- load modules --
------------------

-- theme
local theme = require "theme"

-- module
require "bar.module"

-- time event
require "events.date"

-----------------
-- date module --
-----------------

local date_module = bar_module_create({
    icon = "",
    icon_color = theme.bar_module_date_color
})

-------------------------
-- update textbox time --
-------------------------

awesome.connect_signal("date::updated",
    function(date)
        bar_module_update_display(date_module, "", date)
    end
)

-------------------
-- return widget --
-------------------

return date_module.widget
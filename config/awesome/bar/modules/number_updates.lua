------------------
-- load modules --
------------------

-- theme
local theme = require "theme"

-- module
require "bar.module"

-- number updates event
require "events.number_updates"

---------------------------
-- number updates module --
---------------------------

local nb_updates_module = bar_module_create({
    icon = "",
    icon_color = theme.bar_module_updates_color
})

-------------------------
-- update textbox time --
-------------------------

awesome.connect_signal("number_updates::updated",
    function(number_updates)
        bar_module_update_display(nb_updates_module, "", tostring(number_updates))
    end
)

-------------------
-- return widget --
-------------------

return nb_updates_module.widget
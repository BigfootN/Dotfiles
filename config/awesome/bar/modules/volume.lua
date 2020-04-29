------------------
-- load modules --
------------------

-- theme
local theme = require "theme"

-- module
require "bar.module"

-- volume event
require "events.volume"

--------------------------
-- create volume module --
--------------------------

local volume_module = bar_module_create({
    icon = "",
    icon_color = theme.bar_module_volume_color
})

--------------------------
-- update volume module --
--------------------------

awesome.connect_signal("volume::updated",
    function(volume)
        if (volume.toggled == false) then
            bar_module_update_display(volume_module, "")
        else
            bar_module_update_display(volume_module, "", volume.height)
        end
    end
)

-------------------
-- return widget --
-------------------

return volume_module.widget
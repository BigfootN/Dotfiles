------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- gears
local gears = require "gears"

-- theme
local theme = require "theme"

---------------
-- variables --
---------------

DATE_UPDATE_COMPLETED = true

-----------------
-- update time --
-----------------

local update_date = function()
    local cmd = [[TZ=']]..theme.time_timezone..[[' date +'%d/%m']]

    awful.spawn.easy_async_with_shell(cmd,
        function(stdout, stderr, exitreason, exitcode)
            local date = string.gsub(stdout,"\n*$","")
            awesome.emit_signal("date::updated", date)
            DATE_UPDATE_COMPLETED = true
        end
    )
end

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback =
        function()
            if (DATE_UPDATE_COMPLETED) then
                DATE_UPDATE_COMPLETED = false
                update_date()
            end
        end
}
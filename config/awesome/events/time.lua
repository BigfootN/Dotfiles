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

TIME_UPDATE_COMPLETED = true

-----------------
-- update time --
-----------------

local update_time = function()
    local cmd = [[TZ=']]..theme.time_timezone..[[' date +'%H:%M']]

    awful.spawn.easy_async_with_shell(cmd,
        function(stdout, stderr, exitreason, exitcode)
            local time = string.gsub(stdout,"\n*$","")
            awesome.emit_signal("time::updated", time)
            TIME_UPDATE_COMPLETED = true
        end
    )
end

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback =
        function()
            if (TIME_UPDATE_COMPLETED) then
                TIME_UPDATE_COMPLETED = false
                update_time()
            end
        end
}
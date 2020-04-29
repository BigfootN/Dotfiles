------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- gears
local gears = require "gears"

----------------------
-- global variables --
----------------------

CHECK_COMPLETED = true
LAST_CPU_USAGE = nil

---------------
-- cpu usage --
---------------

local update_cpu_usage = function()
    local cmd = [[top -bn3 | grep "Cpu(s)" | tail -1 | sed -e 's/\,/\./g' | awk '{print 100-$8}']]

    awful.spawn.easy_async_with_shell(cmd,
        function(stdout, stderr, exitcode, exitreason)
            if LAST_CPU_USAGE ~= stdout then
                LAST_CPU_USAGE = tonumber(stdout)
                awesome.emit_signal("cpu::changed", LAST_CPU_USAGE)
                CHECK_COMPLETED = true
            end
        end
    )
end

gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback =
        function()
            if (CHECK_COMPLETED) then
                CHECK_COMPLETED = false
                update_cpu_usage()
            end
        end
}
------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- gears
local gears = require "gears"

---------------
-- variables --
---------------

NUMBER_UPDTAES_CHECK_COMPLETED = true

------------------------------
-- number of updates update --
------------------------------

local check_number_aur_updates = function(number_arch_updates)
    local cmd = [[yay -Qum > /dev/null | wc -l]]

    awful.spawn.easy_async_with_shell(cmd,
        function(stdout, stderr, exitreason, exitcode)
            local number_aur_updates = string.gsub(stdout, "\n*$", "")
            if (number_aur_updates == "") or (number_aur_updates == "0") then
                number_aur_updates = 0
            else
                number_aur_updates = tonumber(number_aur_updates)
            end
            
            local total_number_updates = number_aur_updates + number_arch_updates
            awesome.emit_signal("number_updates::updated", total_number_updates)
            NUMBER_UPDTAES_CHECK_COMPLETED = true
        end
    )
end

local check_number_arch_updates = function()
    local cmd = [[checkupdates > /dev/null | wc -l]]

    awful.spawn.easy_async_with_shell(cmd,
        function(stdout, stderr, exitreason, exitcode)
            local number_arch_updates = string.gsub(stdout,"\n*$","")
            if (number_arch_updates == "") or (number_arch_updates == "0") then
                number_arch_updates = 0
            else
                number_arch_updates = tonumber(number_arch_updates)
            end

            check_number_aur_updates(number_arch_updates)
        end
    )
end

gears.timer {
    autostart = true,
    timeout = 350,
    call_now = true,
    callback =
        function()
            if (NUMBER_UPDTAES_CHECK_COMPLETED) then
                NUMBER_UPDTAES_CHECK_COMPLETED = false

                check_number_arch_updates()
            end
        end
}
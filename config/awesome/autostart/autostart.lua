------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- environment variables
local vars = require "utils.env_variables"

--------------------------
-- autostarts a program --
--------------------------

function autostart(program)
	local cmd = nil

	if program.single_instance then
		cmd = [[pgrep -u ]]..vars.user..[[ -x ]]..program.name..[[ > /dev/null || ]]..program.bin..[[ ]]..program.args
	else
		cmd = program.bin..[[ ]]..program.args
	end
		
	awful.spawn.easy_async_with_shell(cmd, false)
end

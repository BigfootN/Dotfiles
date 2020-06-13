------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- environmental variables
local theme = require "theme"

-- applications
local apps = require "settings.apps"

-------------------
-- key variables --
-------------------

local ctrl = "Control"
local super = "Mod4"
local alt = "Mod1"
local shift = "Shift"

local modkey = super

---------------
-- functions --
---------------

-- kill all clients
local kill_all_clients = function()
	for k, v in pairs(screen[1]:get_all_clients()) do
		v:kill()
	end
end

-- move client next tag
local move_client_next_tag = function(c)
	c = c or client.focus

	if c ~= nil then
		local client_tag_idx = c.first_tag.index
		local new_tag_idx = (client_tag_idx % theme.nb_tagnames) + 1

		c:move_to_tag(screen[1].tags[new_tag_idx])
		awful.tag.viewnext(screen[1])
	end
end

-- move client prev tag
local move_client_prev_tag = function(c)
	c = c or client.focus

	if c ~= nil then
		local client_tag_idx = c.first_tag.index
		local new_tag_idx = ((client_tag_idx - 2) % theme.nb_tagnames) + 1

		c:move_to_tag(screen[1].tags[new_tag_idx])
		awful.tag.viewprev(screen[1])
	end
end

-----------------
-- keybindings --
-----------------

-- keyboard apps launch bindings
awful.keyboard.append_global_keybindings({
	awful.key({modkey}, "t",
		function()
			apps.spawn_app(apps.terminal)
		end
	),
	awful.key({modkey}, "b",
		function()
			apps.spawn_app(apps.browser)
		end
	),
	awful.key({modkey}, "f",
		function()
			apps.spawn_app(apps.file_manager)
		end
	),
	awful.key({modkey}, "e",
		function()
			apps.spawn_app(apps.editor)
		end
	),
	awful.key({modkey}, "d",
		function()
			apps.spawn_app(apps.torrent_client)
		end
	),
	awful.key({modkey}, "l",
		function()
			apps.spawn_app(apps.screen_locker)
		end
	),
	awful.key({modkey}, "m",
		function()
			apps.spawn_app(apps.music)
		end
	)
})

-- navigate through tags
awful.keyboard.append_global_keybindings({
	awful.key({modkey, alt}, "Right",
		function()
			local screen = awful.screen.focused()

			awful.tag.viewnext(screen)
		end
	),
	awful.key({modkey, alt}, "Left",
		function()
			local screen = awful.screen.focused()

			awful.tag.viewprev(screen)
		end
	)
})

-- client bindings
awful.keyboard.append_global_keybindings({
	awful.key({modkey}, "k",
		function()
			local focused_client = client.focus

			if (focused_client ~= nil) then
				focused_client:kill()
			end
		end
	)
})

-- system bindings
awful.keyboard.append_global_keybindings({
	awful.key({modkey}, "q",
		function()
			local stop_mpd_cmd = [[mpc stop]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)

			kill_all_clients()
			awesome.quit()
		end
	),
	awful.key({modkey}, "s",
		function()
			awful.spawn.easy_async_with_shell([[shutdown -h now]], false)
		end
	),
	awful.key({modkey}, "r",
		function()
			awful.spawn.easy_async_with_shell([[shutdown -r now]], false)
		end
	)
})

-- navigate through clients
awful.keyboard.append_global_keybindings({
	awful.key({modkey}, "Right",
		function()
			awful.client.focus.bydirection("right")
		end
	),
	awful.key({modkey}, "Left",
		function()
			awful.client.focus.bydirection("left")
		end
	),
	awful.key({modkey}, "Up",
		function()
			awful.client.focus.bydirection("up")
		end
	),
	awful.key({modkey}, "Down",
		function()
			awful.client.focus.bydirection("down")
		end
	)
})

-- media keys
awful.keyboard.append_global_keybindings({
	awful.key({},"XF86AudioLowerVolume",
		function()
			local cmd = [[amixer sset Master 5%-]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)
		end
	),
	awful.key({},"XF86AudioRaiseVolume",
		function()
			local cmd = [[amixer sset Master 5%+]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)
		end
	),
	awful.key({},"XF86AudioMute",
		function()
			local cmd = [[amixer sset Master toggle]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)
		end
	),
	awful.key({},"XF86AudioNext",
		function()
			local cmd = [[mpc next]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)
		end
	),
	awful.key({},"XF86AudioPrev",
		function()
			local cmd = [[mpc prev]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)
		end
	),
	awful.key({},"XF86AudioPlay",
		function()
			local cmd = [[mpc toggle]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)
		end
	),
	awful.key({},"XF86AudioStop",
		function()
			local cmd = [[mpc stop]]

			awful.spawn.easy_async_with_shell(cmd,
				function(stdout, stderr, exitcode, exitreason)
				end
			)
		end
	)
})

-- move clients
awful.keyboard.append_global_keybindings({
	awful.key({modkey, shift}, "Right",
		function()
			move_client_next_tag()
		end
	),
	awful.key({modkey, shift}, "Left",
		function()
			move_client_prev_tag()
		end
	)
})

-- swap clients
awful.keyboard.append_global_keybindings({
	awful.key({modkey, ctrl, shift}, "Left",
		function()
			awful.client.swap.bydirection("left")
		end
	),
	awful.key({modkey, ctrl, shift}, "Right",
		function()
			awful.client.swap.bydirection("right")
		end
	),
	awful.key({modkey, ctrl, shift}, "Up",
		function()
			awful.client.swap.bydirection("up")
		end
	),
	awful.key({modkey, ctrl, shift}, "Down",
		function()
			awful.client.swap.bydirection("down")
		end
	)
})

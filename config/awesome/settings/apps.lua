------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- theme
local theme = require "theme"

------------------
-- applications --
------------------

local apps = {}

-- terminal
apps.terminal = {
	name = "kitty",
	ruled = true,
	bin = "kitty",
	args = "",
	instance = "kitty",
	single_instance = false,
	tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_TERMINAL_NAME_ICON),
	autostart = false
}

-- browser
apps.browser = {
	name = "firefox",
	ruled = true,
	bin = "firefox",
	args = "",
	instance = "Navigator",
	single_instance = true,
	tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_BROWSER_NAME_ICON),
	autostart = false
}

-- file manager
apps.file_manager = {
	name = "nemo",
	ruled = true,
	bin = "nemo",
	args = "",
	instance = "nemo",
	single_instance = true,
	tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_FILE_NAME_ICON),
	autostart = false
}

-- torrent client
apps.torrent_client = {
	name = "transmission-gtk",
	ruled = true,
	bin = "transmission-gtk",
	args = "",
	instance = "transmission-gtk",
	single_instance = true,
	tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_TORRENT_NAME_ICON),
	autostart = false
}

-- editor
apps.editor = {
	name = "nvim",
	ruled = true,
	bin = apps.terminal.bin,
	args = [[--name=neovim nvim]],
	instance = "neovim",
	single_instance = true,
	tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_CODE_NAME_ICON),
	autostart = false
}

-- music
apps.music = {
	name="ncmpcpp",
	ruled = true,
	bin = apps.terminal.bin,
	args = [[--name=ncmpcpp ncmpcpp]],
	instance = "ncmpcpp",
	single_instance = true,
	tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_MUSIC_NAME_ICON),
	autostart = false
}

-- compositor
apps.compositor = {
	name = "picom",
	ruled = false,
	bin = "picom",
	args = "",
	instance = nil,
	tag = nil,
	single_instance = true,
	autostart = true
}

-- screen locker
apps.screen_locker = {
	name = "betterlockscreen",
	ruled = false,
	bin = "betterlockscreen",
	args = "-l",
	instance = nil,
	tag = nil,
	single_instance = false,
	autostart = false
}

-- keyboard settings
apps.keyboard = {
	name = "xset",
	ruled = false,
	bin = "xset",
	instance = nil,
	args = "r rate 150 130",
	single_instance = false,
	autostart = true
}

-- go to browser
local focus_or_spawn = function(app)
	local clients = screen[1]:get_all_clients()
	local app_client = nil
	local cmd = app.bin..[[ ]]..app.args

	for _, c in pairs(clients) do
		local found = string.find(app.instance, c.instance)

		if found ~= nil then
			app_client = c
		end
	end

	if app_client == nil then
		awful.spawn(cmd, {
				tag = app.tag
			})
	else
		app_client:move_to_tag(app.tag)
		app_client:activate()
		app.tag:view_only()
	end
end

function apps.spawn_app(app)
	local cmd = app.bin..[[ ]]..app.args

	if app.with_shell == true then
		awful.spawn.easy_async_with_shell(cmd,
			function(stdout, stderr, exitcode, exitreason)
			end
			)
	elseif app.single_instance == false then
		awful.spawn(cmd, {
				tag = app.tag
			})
	else
		focus_or_spawn(app)
	end
end

return apps

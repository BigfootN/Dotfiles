------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- gears
local gears = require "gears"

require "utils.table"

---------------
-- variables --
---------------

LAST_MUSIC = {}
CURRENT_MUSIC = {}
CHECK_COMPLETED = true
COVER_IMAGE_PATH = "/tmp/mpd_cover.jpg"

---------------
-- functions --
---------------

-- extract cover
local extract_cover = function(file_path)
	local cmd = ""
	local file = io.open("/tmp/mpd_cover_tmp", "w+")

	os.remove(COVER_IMAGE_PATH)
	COVER_IMAGE_PATH = [[/tmp/]]..LAST_MUSIC.artist..[[.jpg]]
	cmd = [[ffmpeg -y -i "]]..file_path..[[" ]]..[["]]..COVER_IMAGE_PATH..[["]]
	collectgarbage("collect")

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitcode, exitreason)
			awesome.emit_signal("music::changed", LAST_MUSIC, COVER_IMAGE_PATH)
			CHECK_COMPLETED = true
		end
	)
end

-- extract path
local get_file_path = function()
	local cmd = [[echo "$(xdg-user-dir MUSIC)/$(mpc current --format %file%)"]]

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitcode, exitreason)
			local file_path = string.gsub(stdout,"\n*$","");
			extract_cover(file_path)
		end
	)
end

-- check if music has changed
local check_if_music_changed = function()
	local same_music = table_equals(CURRENT_MUSIC, LAST_MUSIC)

	if (same_music == false) then
		LAST_MUSIC = CURRENT_MUSIC
		get_file_path()
	else
		CHECK_COMPLETED = true
	end
end

-- update artist
local update_artist = function ()
	local cmd = [[mpc current --format %artist% | tr -d '\n']]

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitcode, exitreason)
			local artist = string.gsub(stdout,"\n*$","")
			CURRENT_MUSIC.artist = artist
			check_if_music_changed()
		end
	)
end

-- update album
local update_album = function()
	local cmd = [[mpc current --format %album% | tr -d '\n']]

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitcode, exitreason)
			local album = string.gsub(stdout,"\n*$","")
			CURRENT_MUSIC.album = album
			update_artist()
		end
	)
end

-- update title
local update_title = function()
	local cmd = [[mpc current --format %title% | tr -d '\n']]

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitcode, exitreason)
			local title = string.gsub(stdout,"\n*$","")
			CURRENT_MUSIC.title = stdout
			update_album()
		end
	)
end

local update_metadata = function()
	update_title()
end

-- check if mpd is still playing
local update_current_music_status = function()
	local cmd = [[cut -d' ' -f1 <<< $(mpc status | sed -n '2p') | sed 's/\]//g' | sed 's/\[//g']]

	awful.spawn.easy_async_with_shell(cmd,
		function(stdout, stderr, exitcode, exitreason)
			local status = string.gsub(stdout, "\n*$", "")

			CHECK_COMPLETED = false
			CURRENT_MUSIC = {}

			if string.len(status) >= 2 then
				CURRENT_MUSIC.status = status
				update_metadata()
			else
				LAST_MUSIC = {}
				awesome.emit_signal("music::stopped")
				CHECK_COMPLETED = true
			end
		end
	)
end

gears.timer {
	timeout = 1,
	autostart = true,
	call_now = true,
	callback = function()
		if (CHECK_COMPLETED == true) then
			update_current_music_status()
		end
	end
}

pcall(require, "luarocks.loader")

------------------
-- load modules --
------------------

-- gears
local gears = require "gears"

-- beautiful
local theme = require "theme"

-- wibox
require "bar"

-- client settings
require "settings"

-- autostart
require "autostart"

-- music popup
require "widgets.popup_music"

-- bindings
require "bindings"

-- popup volume
require "widgets.popup_volume"

-------------------
-- set wallpaper --
-------------------

gears.wallpaper.maximized(theme.wallpaper, screen[1])

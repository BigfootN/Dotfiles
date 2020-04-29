------------------
-- load modules --
------------------

-- calculations
local calcs = require "utils.calculations"

---------------------
-- screen settings --
---------------------

-- padding
screen[1].autodpi = true
screen[1].padding = {
    top = calcs.screen_padding_top,
    left = calcs.screen_padding_left,
    bottom = calcs.screen_padding_bottom,
    right = calcs.screen_padding_right
}
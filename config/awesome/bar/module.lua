------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- wibox
local wibox = require "wibox"

-- theme
local theme = require "theme"

-- calculations
local calcs = require "utils.calculations"

------------------
-- module class --
------------------

-- icon textbox and widget function creators
local create_icon_textbox = function(module)
	module.icon_textbox = wibox.widget {
		valign = "center",
		align = "center",
		font = theme.bar_module_icon_font,
		text = module.icon.." ",
		forced_height = calcs.bar_height,
		widget = wibox.widget.textbox
	}
end

local create_icon_widget = function(module)
	create_icon_textbox(module)

	module.icon_widget = wibox.widget {
		module.icon_textbox,
		fg = module.icon_color,
		bg = theme.bar_bg,
		forced_height = calcs.bar_height,
		widget = wibox.container.background
	}
end

-- label textbox and widget function creators
local create_label_textbox = function(module)
	module.label_textbox = wibox.widget {
		valign = "center",
		align = "center",
		font = theme.bar_module_label_font,
		forced_height = calcs.bar_height,
		widget = wibox.widget.textbox
	}
end

local create_label_widget = function(module)
	create_label_textbox(module)

	module.label_widget = wibox.widget {
		module.label_textbox,
		forced_height = calcs.bar_height,
		fg = theme.bar_module_label_color,
		bg = theme.bar_bg,
		widget = wibox.container.background
	}
end

-- create main widget function
local create_main_widget = function(module)
	create_label_widget(module)
	create_icon_widget(module)

	module.widget = wibox.widget {
		{
			module.icon_widget,
			module.label_widget,
			spacing = module.spacing,
			layout = wibox.layout.fixed.horizontal
		},
		forced_height = calcs.bar_height,
		bg = theme.bar_bg,
		widget = wibox.container.background
	}
end

-- update textbox content
local update_textbox_content = function(textbox, text)
	local new_text = ""

	if text ~= nil then
		new_text = tostring(text)
	end

	textbox.text = new_text
	textbox:emit_signal("widget::redraw_needed")
	textbox:emit_signal("widget::layout_changed")
end

function bar_module_create(args)
	local ret = args or {}

	ret.icon = args.icon or ""
	ret.icon_color = args.icon_color
	ret.spacing = args.spacing or 5

	create_main_widget(ret)

	return ret
end

function bar_module_update_display(module, icon, label)
	update_textbox_content(module.icon_textbox, icon.." ")
	update_textbox_content(module.label_textbox, label)
end

------------------
-- load modules --
------------------

-- awful
local awful = require "awful"

-- ruled
local ruled = require "ruled"

-- theme
local theme = require "theme"

-- apps
local apps = require "settings.apps"

-----------
-- rules --
-----------
local file = io.open("/tmp/rules", "w+")
ruled.client.connect_signal("request::rules",
    function()
        ruled.client.append_rule {
            rule = {},
            properties = {
                shape = theme.client_shape,
                border_width = theme.client_border_width,
                size_hints_honor = false,
                focus = true
            }
        }

        for _, app in pairs(apps) do
            if (type(app) ~= "function") and app.ruled then
                file:write("found app.."..app.name.."\n")
                file:flush()
                ruled.client.append_rule {
                    rule_any = {
                        class = app.class
                    },
                    properties = {
                        tag = awful.tag.find_by_name(screen[1], app.tag),
                        switch_to_tags = true
                    }
                }
                file:write("appended rule for.."..app.name.."\n")
                file:flush()
            end
        end

        -- where to start file manager
        -- ruled.client.append_rule {
        --     rule_any = {
        --         class = {
        --             "Nemo",
        --             "nemo"
        --         }
        --     },
        --     properties = {
        --         tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_FILE_NAME_ICON),
        --         switch_to_tags = true
        --     }
        -- }

        -- -- where to start browser
        -- ruled.client.append_rule {
        --     rule_any = {
        --         class = {
        --             "Navigator",
        --             "firefox"
        --         }
        --     },
        --     properties = {
        --         tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_BROWSER_NAME_ICON),
        --         switch_to_tags = true
        --     }
        -- }

        -- -- where to start terminal
        -- ruled.client.append_rule {
        --     rule_any = {
        --         class = {
        --             "gnome-terminal-server",
        --             "Gnome-terminal"
        --         }
        --     },
        --     properties = {
        --         tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_TERMINAL_NAME_ICON),
        --         switch_to_tags = true
        --     }
        -- }

        -- -- where to start editor
        -- ruled.client.append_rule {
        --     rule_any = {
        --         class = {
        --             "code",
        --             "Code"
        --         }
        --     },
        --     properties = {
        --         tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_CODE_NAME_ICON),
        --         switch_to_tags = true
        --     }
        -- }

        -- -- where to start gnome torrent
        -- ruled.client.append_rule {
        --     rule_any = {
        --         class = {
        --             "transmission-gtk",
        --             "Transmission-gtk"
        --         }
        --     },
        --     properties = {
        --         tag = awful.tag.find_by_name(screen[1], theme.tag_names.TAG_TORRENT_NAME_ICON),
        --         switch_to_tags = true
        --     }
        -- }

        -- -- where to place dialogs
        -- ruled.client.append_rule {
        --     rule_any = {
        --         type = {
        --             "dialog"
        --         }
        --     },
        --     properties = {
        --         placement = awful.placement.centered
        --     }
        -- }
    end
)
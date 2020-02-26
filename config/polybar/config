; $$$$$$$\            $$\           $$\                            $$$$$$\                       $$$$$$\  $$\           
; $$  __$$\           $$ |          $$ |                          $$  __$$\                     $$  __$$\ \__|          
; $$ |  $$ | $$$$$$\  $$ |$$\   $$\ $$$$$$$\   $$$$$$\   $$$$$$\  $$ /  \__| $$$$$$\  $$$$$$$\  $$ /  \__|$$\  $$$$$$\  
; $$$$$$$  |$$  __$$\ $$ |$$ |  $$ |$$  __$$\  \____$$\ $$  __$$\ $$ |      $$  __$$\ $$  __$$\ $$$$\     $$ |$$  __$$\ 
; $$  ____/ $$ /  $$ |$$ |$$ |  $$ |$$ |  $$ | $$$$$$$ |$$ |  \__|$$ |      $$ /  $$ |$$ |  $$ |$$  _|    $$ |$$ /  $$ |
; $$ |      $$ |  $$ |$$ |$$ |  $$ |$$ |  $$ |$$  __$$ |$$ |      $$ |  $$\ $$ |  $$ |$$ |  $$ |$$ |      $$ |$$ |  $$ |
; $$ |      \$$$$$$  |$$ |\$$$$$$$ |$$$$$$$  |\$$$$$$$ |$$ |      \$$$$$$  |\$$$$$$  |$$ |  $$ |$$ |      $$ |\$$$$$$$ |
; \__|       \______/ \__| \____$$ |\_______/  \_______|\__|       \______/  \______/ \__|  \__|\__|      \__| \____$$ |
;                         $$\   $$ |                                                                          $$\   $$ |
;                         \$$$$$$  |                                                                          \$$$$$$  |
;                          \______/                                                                            \______/ 

#----------#
# Sections #
#----------#

[section/base]
label-font = 1
format-prefix-font = 2
format-prefix-padding = 1

[colors]

; background
bg = #2d2d2d

; border color
border = #767676

[section/bar_settings]
; height
height = 2.5%

; colors
background = ${colors.bg}
foreground = #ffffff

; borders color
border-top-color = #2d2d2d
border-bottom-color = #2d2d2d
border-right-color = #2d2d2d

; center modules
fixed-center = true

; font
font-0 = "Iosevka:size=12;3"
font-1 = "Iosevka Term:size=18;5"
font-2 = "Iosevka Term:size=22;5"

; padding
padding = 2

; line
line-size = 10
line-color = ${colors.border}

; override (necessary for offset)
override-redirect = true

; borders size
border-left-size = 0
border-right-size = 5
border-bottom-size = 8
border-top-size = 8

; modules margin
module-margin = 1

; wm restack
wm-restack = i3

#------#
# Bars #
#------#

[bar/top]
; top
bottom = false

; inherit
inherit = section/bar_settings

; geometry
width = 96.6%

; colors
foreground = #ffffff

; offset
offset-y = 10
offset-x = 1.7%

; modules
modules-right = date time
modules-center = status artist title
modules-left = i3

; language
locale = fr_FR.UTF-8

[bar/system]
; bottom
bottom = true

; inherit
inherit = section/bar_settings

; modules
modules-center = updates sound memory cpu wireless-network

; position
offset-x = 36.7%
offset-y = 10

; geometry
width = 26.5%

#---------#
# Modules #
#---------#

[module/i3]
type = internal/i3

inherit = section/base

; disable scrolling
enable-scroll = false

format = <label-state>

; focused format
label-focused = ""
label-focused-foreground = #e87d4c
label-focused-background = ${colors.bg}
label-focused-font = 3
label-focused-padding = 1

; unfocused format
label-unfocused = %icon%
label-unfocused-foreground = #b5b5b5
label-unfocused-background = ${colors.bg}
label-unfocused-font = 3
label-unfocused-padding = 1

; visible format
label-visible = %icon%
label-visible-foreground = #b5b5b5
label-visible-background = ${colors.bg}
label-visible-font = 3
label-visible-padding = 1

; urgent format
label-urgent = %icon%
label-urgent-foreground = #b5b5b5
label-urgent-background = ${colors.bg}
label-urgent-font = 3
label-urgent-padding = 1

; default icon
ws-icon-default = ""

label-seperator-padding = 0


[module/cpu]
type = internal/cpu

format = <label>
format-prefix = %{O0}
format-prefix-background = #689d6a
format-prefix-foreground = #000000

label = %{B#a2a2a2 F#000000}%{O0} %percentage%% %{B- F-}
inherit = section/base

[module/wireless-network]
type = internal/network
interface = wlp2s0
inherit = section/base

; format
format-connected = <label-connected>
format-connected-prefix =  %{O0}
format-connected-prefix-background = #fe8019
format-connected-prefix-foreground = #000000
format-connected-prefix-font = 2
format-connected-prefix-padding = 1

; label
label-connected = %{B#a2a2a2 F#000000}%{O-10} %essid% %{B- F-}

; refresh time
interval = 1

[module/time]
type = internal/date
time = %H:%M
interval = 1

; format
format = <label>
format-prefix =  %{O0}
format-prefix-background = #98971a
format-prefix-foreground = #000000

; label
label = %{B#a2a2a2 F#000000}%{O-10} %time% %{B- F-}

; inheritance
inherit = section/base

[module/date]
type = internal/date
date = %a %d/%m
interval = 1
inherit = section/base

; format
format = <label>
format-prefix = %{O0}
format-prefix-background = #cc241d
format-prefix-foreground = #000000

; label
label = %{B#a2a2a2 F#000000}%{O-10} %date% %{B- F-}
format-label-background = #a2a2a2

[module/memory]
type = internal/memory
inherit = section/base

; format
format = <label>
format-prefix =  %{O0}
format-prefix-background = #928374
format-prefix-foreground = #000000

; label
label = %{B#a2a2a2 F#000000}%{O-10} %percentage_used%% %{B- F-}

[module/artist]
type = custom/script
tail = true

;inherit
inherit = section/base

; format
format = <label>
format-prefix = ﴁ %{O0}
format-prefix-background = #076678
format-prefix-foreground = #000000

; label
label = %{B#a2a2a2 F#000000}%{O-10} %output:0:100% %{B- F-}

; exec
exec-if = ~/.config/polybar/musicinfo.py song "%a"
exec = ~/.config/polybar/musicinfo.py song "%a"
interval = 1

[module/title]
type = custom/script
tail = true

; inherit
inherit = section/base

; format
format = <label>
format-prefix =  %{O0}
format-prefix-background = #d3869b
format-prefix-foreground = #000000

; label
label = %{B#a2a2a2 F#000000}%{O-10} %output:0:100% %{B- F-}

; exec
exec-if = ~/.config/polybar/musicinfo.py song "%t"
exec = ~/.config/polybar/musicinfo.py song "%t"
interval = 1

[module/updates]
type = custom/script
tail = true

; inherit
inherit = section/base

; format
format = <label>
format-prefix = ﰶ %{O0}
format-prefix-background = #d79921
format-prefix-foreground = #000000

; label
label = %{B#a2a2a2 F#000000}%{O-10} %output% %{B- F-}

; exec
exec = ~/.config/polybar/updates.sh
interval = 10

[module/status]
type = custom/script
tail = true

; inherit
inherit = section/base

; format
format = <label>

; exec
exec-if = /usr/bin/python ~/.config/polybar/musicinfo.py command status
exec = ~/.config/polybar/musicstatus.sh
interval = 1

; label
label = %{B#d87c47 F#000000}%{O-15}  %output% %{B- F-}
label-font = 2

[module/sound]
type = internal/alsa

; inherit
inherit = section/base

; soundcards
master-soundcard = hw:0
speaker-soundcard = hw:0
headphone-soundcard = hw:0

; format muted
format-muted = <label-muted>
label-muted-foreground = #000000
label-muted-background = #686868

; label muted
label-muted = %{B#686868 F#000000} 婢 %{B-F-}
label-muted-font = 2

; format volume
format-volume = <ramp-volume> <label-volume>
format-volume-foreground = #000000
format-volume-background = #686868
format-volume-font = 2

; label volume
label-volume = " %percentage% "
label-volume-font = 1
label-volume-foreground = #000000
label-volume-background = #a2a2a2

; ramp
ramp-volume-0 = " "
ramp-volume-1 = " "
ramp-volume-2 = " "
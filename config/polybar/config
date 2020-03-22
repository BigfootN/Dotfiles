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
height = 2.8%

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
font-0 = "UbuntuCondensed Nerd Font:size=14;3"

; padding
padding = 2

; line
line-size = 10
line-color = ${colors.border}

; override (necessary for offset)
override-redirect = true

; borders size
border-left-size = 0
border-right-size = 7
border-bottom-size = 5
border-top-size = 7

; modules margin
module-margin = 1

; wm restack
wm-restack = i3

#------#
# Bars #
#------#

[bar/main]
; top
bottom = false

; inherit
inherit = section/bar_settings

; geometry
width = 100%

; colors
foreground = #ffffff

; offset
offset-y = 0
offset-x = 0

; modules
modules-right = sound wireless-network date time
modules-center = song
modules-left = i3

; language
locale = fr_FR.UTF-8

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
format-prefix-background = ${colors.bg}

[module/wireless-network]
type = internal/network
interface = wlp2s0
inherit = section/base

; format
format-connected = <label-connected>
format-connected-prefix = 
format-connected-prefix-background = ${colors.bg}
format-connected-prefix-foreground = #98971a
format-connected-prefix-padding = 1

; label
label-connected = %{F#98971a} %essid% %{F-}

; refresh time
interval = 1

[module/time]
type = internal/date
time = %H:%M
interval = 1

; format
format = <label>
format-prefix = 
format-prefix-background = ${colors.bg}
format-prefix-foreground = #cc241d

; label
label = %{F#cc241d}%time%%{F-}

; inheritance
inherit = section/base

[module/date]
type = internal/date
date = %d/%m
interval = 1
inherit = section/base

; format
format = <label>
format-prefix =
format-prefix-background = ${colors.bg}
format-prefix-foreground = #d65d0e

; label
label = %{F#d65d0e} %date% %{F-}

[module/song]
type = custom/script
tail = true

;inherit
inherit = section/base

; format
format = <label>
format-prefix = 
format-prefix-background = ${colors.bg}
format-prefix-foreground = #458588

; label
label = %{F#458588} %output:0:100% %{F-}

; exec
exec-if = ~/.config/polybar/musicinfo.py song "%a  %t"
exec = ~/.config/polybar/musicinfo.py song "%a  %t"
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
label-muted-foreground = #d79921
label-muted-background = ${colors.bg}

; label muted
label-muted = %{F#d79921} 婢 %{F-}

; format volume
format-volume = <ramp-volume> <label-volume>
format-volume-foreground = #d79921
format-volume-background = ${colors.bg}

; label volume
label-volume = " %percentage% "
label-volume-foreground = #d79921
label-volume-background = ${colors.bg}

; ramp
ramp-volume-2 = " "
ramp-volume-1 = " "
ramp-volume-0 = " "
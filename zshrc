# ——————————————————————————————————————————————
#
# ▒███████▒  ██████  ██░ ██  ██▀███   ▄████▄
# ▒ ▒ ▒ ▄▀░▒██    ▒ ▓██░ ██▒▓██ ▒ ██▒▒██▀ ▀█
# ░ ▒ ▄▀▒░ ░ ▓██▄   ▒██▀▀██░▓██ ░▄█ ▒▒▓█    ▄
#   ▄▀▒   ░  ▒   ██▒░▓█ ░██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
# ▒███████▒▒██████▒▒░▓█▒░██▓░██▓ ▒██▒▒ ▓███▀ ░
# ░▒▒ ▓░▒░▒▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░ ▒▓ ░▒▓░░ ░▒ ▒  ░
# ░░▒ ▒ ░ ▒░ ░▒  ░ ░ ▒ ░▒░ ░  ░▒ ░ ▒░  ░  ▒
# ░ ░ ░ ░ ░░  ░  ░   ░  ░░ ░  ░░   ░ ░
#
# ——————————————————————————————————————————————

# ————
# INIT
# ————

# load Xresources
if [ -f ~/.Xresources ]
then
	xrdb ~/.Xresources
fi

# zsh modules
zmodload zsh/mathfunc

# cursor speed
xset r rate 150 170

# —————————————————
# POLYBAR VARIABLES
# —————————————————

POLYBAR_HEIGHT_PERC=3
POLYBAR_WIDTH_PERC=98.0
POLYBAR_OFFSET_Y_PERC=1
POLYBAR_OFFSET_X=0
POLYBAR_OFFSET_Y=0
POLYBAR_WIDTH=0
POLYBAR_HEIGHT=0

function dimensions() {
	screen_dims=$(xrandr | grep '*' | awk '{print $1;}')
	screen_width=$(echo $screen_dims | cut -d 'x' -f 1)
	screen_height=$(echo $screen_dims | cut -d 'x' -f 2)

	export POLYBAR_WIDTH=$((($screen_width*$POLYBAR_WIDTH_PERC)/100))
	export POLYBAR_HEIGHT=$((($screen_height*$POLYBAR_HEIGHT_PERC)/100))
}

function offsets() {
	screen_dims=$(xrandr | grep '*' | awk '{print $1;}')
	screen_width=$(echo $screen_dims | cut -d 'x' -f 1)
	screen_height=$(echo $screen_dims | cut -d 'x' -f 2)

	offset_perc=$(((100-$POLYBAR_WIDTH_PERC)/2))
	export POLYBAR_OFFSET_X=$((($offset_perc*$screen_width)/100))
	export POLYBAR_OFFSET_Y=$((($POLYBAR_OFFSET_Y_PERC*$screen_height)/100))
}

# calculate dimensions
dimensions
offsets

# ————————
# SETTINGS
# ————————

# antigen plugin path
ADOTDIR="$HOME/.antigen"

# keyboard speed
xset r rate 180 100

# language environment
export LANG=fr_FR.UTF-8

# editor
export EDITOR='nano'

# npm
PATH="$HOME/.node_modules/bin/:$PATH"
export npm_config_prefix=~/.node/modules

# ———————
# ANTIGEN
# ———————

# source antigen
source ~/.antigen/antigen.zsh

# use oh-my-zsh
antigen use oh-my-zsh

# plugins
antigen bundle archlinux
antigen bundle mvn
antigen bundle extract

# done
antigen apply

# —————
# ALIAS
# —————

alias astyle="astyle --options=~/.config/astyle/astylerc"
#alias pacaur="pacaur --noconfirm"
alias mirrupg="sudo reflector --country 'France' --latest 200 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"

# ——————
# PROMPT
# ——————

function powerline_precmd() {
	PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
	for s in "${precmd_functions[@]}"; do
		if [ "$s" = "powerline_precmd" ]; then
			return
		fi
	done
	precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
	install_powerline_precmd
fi

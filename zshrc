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


if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

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

POLYBAR_HEIGHT_PERC=2.5
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

# module font awesome labels
export POLYBAR_CPU_LABEL="%{F#689d6a}$(echo -e '\uf2db')%{F-}  %percentage%"
export POLYBAR_NETWORK_LABEL="%{F#458588}$(echo -e '\uf012')%{F-}  %essid%"
export POLYBAR_DATE_LABEL="%{F#98971a}$(echo -e '\uf017')%{F-}  %time%"

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

# external plugins
antigen bundle https://github.com/zsh-users/zsh-autosuggestions

# themes
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# done
antigen apply

# ————————————————
# HELPER FUNCTIONS
# ————————————————

# cmake build init
cmake_build_prepare() {
	mkdir -p build/{debug,release}
	cmake -G "Unix Makefiles" -DBUILD_TYPE=Debug build/debug .
	cmake -G "Unix Makefiles" -DBUILD_TYPE=Release build/release .
}

# —————————————
# ZSH VARIABLES
# —————————————

export SPACESHIP_CHAR_SYMBOL="➜ "
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

# —————
# ALIAS
# —————

alias astyle="astyle --options=~/.config/astyle/astylerc"
alias mirrupg="sudo reflector --country France --sort rate --age 12 --protocol https --save /etc/pacman.d/mirrorlist"
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"
alias sysupg="mirrupg && yay -Syu --noconfirm --answerclean All --answerdiff None --answeredit None"
alias sysinstall="yay -Sy --noconfirm --answerclean All --answerdiff None --answeredit None"
alias sysrm="yay -Rcsn"
alias syspkgsrc="yay -Qs"
alias cmakeinit="cmake_build_prepare"

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

# cursor speed
xset r rate 150 170

# ————————
# SETTINGS
# ————————

# keyboard speed
xset r rate 180 100

# language environment
export LANG=fr_FR.UTF-8

# editor
export EDITOR=/usr/bin/code

# config path
export XDG_CONFIG_HOME=$HOME/.config

# npm
PATH="$HOME/.node_modules/bin/:$HOME/.scripts:$PATH"
export npm_config_prefix=~/.node/modules

# ———————
# ANTIGEN
# ———————

# source antigen
source ~/.antigen/antigen.zsh

# oh-my-zsh
antigen use oh-my-zsh

# plugins
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle extract

# themes
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# done
antigen apply

# ————————————————
# HELPER FUNCTIONS
# ————————————————

# cmake build init
update_mirrors() {
	servers=$(curl -s "https://www.archlinux.org/mirrorlist/?country=FR&protocol=https&ip_version=6" | sed -e 's/^#Server/Server/' -e '/^#/d')
    echo $servers > mirrorlist
    sudo mv mirrorlist /etc/pacman.d/mirrorlist
}

# exit i3
exit_i3() {
	killall feh
	killall polybar
	i3-msg exit
}

# —————————————
# ZSH VARIABLES
# —————————————

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

# ——————————————————
# SPACESHIP SETTINGS
# ——————————————————

# prompt order
export SPACESHIP_PROMPT_ORDER=(
time          # Time stamps section
user          # Username section
host          # Hostname section
dir           # Current directory section
git           # Git section (git_branch + git_status)
exec_time     # Execution time
line_sep      # Line break
exit_code     # Exit code section
char          # Prompt character
)

# user
export SPACESHIP_USER_SUFFIX=""

# char
export SPACESHIP_CHAR_SYMBOL="➜ "

# host
export SPACESHIP_HOST_PREFIX="$(printf '\u0040')"

# —————
# ALIAS
# —————

# named directories
export dev=~/Documents/Dev

# vpn
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"

# package mgmt
alias sysupg="yay -Syu --noconfirm"
alias sysinstall="yay -Sy --noconfirm"
alias sysrm="yay -Rcsn --noconfirm"
alias syspkgsrc="yay -Qs"
alias sysclean="yay -Scc && sysrm $(yay -Qtdq)"
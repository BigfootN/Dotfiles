#―――――――――――――――――――――――――――――――――――――――――――――――――――
#                      /$$
#                     | $$
#  /$$$$$$$$  /$$$$$$$| $$$$$$$   /$$$$$$   /$$$$$$$
# |____ /$$/ /$$_____/| $$__  $$ /$$__  $$ /$$_____/
#    /$$$$/ |  $$$$$$ | $$  \ $$| $$  \__/| $$
#   /$$__/   \____  $$| $$  | $$| $$      | $$
#  /$$$$$$$$ /$$$$$$$/| $$  | $$| $$      |  $$$$$$$
# |________/|_______/ |__/  |__/|__/       \_______/
#―――――――――――――――――――――――――――――――――――――――――――――――――――

#————————————
#—— PROMPT ——
#————————————

eval "$(starship init zsh)"

#———————————————
#—— OH MY ZSH ——
#———————————————

# plugins
plugins=(
	git
	zsh-autosuggestions
)

# source base directory
export ZSH="/home/bigfoot/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

#———————————
#—— ALIAS ——
#———————————

# vpn
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"
#!/bin/zsh

#———————————————————————————
#—— ENVIRONMENT VARIABLES ——
#———————————————————————————

# language environment
export LANG=fr_FR.UTF-8

# editor
export EDITOR=/usr/bin/code

# config path
export XDG_CONFIG_HOME=$HOME/.config

# cargo, script, ...
export CARGO_INSTALL_ROOT="/home/bigfoot/.cargo"
export PATH="$HOME/.cargo/bin:$HOME/.scripts:$HOME/.node_modules/bin:$PATH"

# color for autosuggestion
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

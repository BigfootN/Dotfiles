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

#———————————————
#—— OH MY ZSH ——
#———————————————

# theme
ZSH_THEME="spaceship"

# plugins
plugins=(
	git
	zsh-autosuggestions
)

# source base directory
export ZSH="/home/bigfoot/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

#——————————————
#—— SETTINGS ——
#——————————————

# language environment
export LANG=fr_FR.UTF-8

# editor
export EDITOR=/usr/bin/nvim

# config path
export XDG_CONFIG_HOME=$HOME/.config

# npm
PATH="$HOME/.node_modules/bin/:$HOME/.scripts:$PATH"
export npm_config_prefix=~/.node/modules

# fzf default command line
export FZF_DEFAULT_COMMAND='fd -E build -E Build -E .svn -E .git'

#——————————————————————————
#—— AUTOSUGGEST SETTINGS ——
#——————————————————————————

# color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

#———————————————
#—— FUNCTIONS ——
#———————————————

create_mpc_all_playlist() {
	local IFS='$\n'
	local playlist_name="Tout"

	mpc rm "$playlist_name"

	mpc listall |
	while IFS='$\n' read -r artist
	do
		mpc add "$artist"
	done
	mpc save "$playlist_name"
}

sysclean() {
	yay -Scc
	sysrm $(yay -Qdt)
	sysrm $(yay -Qet)
	sysrm $(yay -Qtdq)
}

#——————————————————————
#—— SPACESHIP PROMPT ——
#——————————————————————

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
export SPACESHIP_CHAR_SYMBOL=">"
export SPACESHIP_CHAR_SUFFIX=" "

# host
export SPACESHIP_HOST_PREFIX="$(printf '\u0040')"

#———————————
#—— ALIAS ——
#———————————

# utils
alias mirrupg="sudo reflector --country France --sort rate --age 12 --protocol https --save /etc/pacman.d/mirrorlist"

# vpn
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"

# package mgmt
alias sysupg="yay -Syu"
alias sysinstall="yay -S"
alias sysrm="yay -Rcsn --noconfirm"
alias syspkgsrc="yay -Qs"
alias sysclean="yay -Scc && sysrm $(yay -Qtdq)"

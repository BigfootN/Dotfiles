# ————————————————————————————————————————————————————————
# /$$           /$$   /$$                /$$
#|__/          |__/  | $$               |__/
# /$$ /$$$$$$$  /$$ /$$$$$$   /$$    /$$ /$$ /$$$$$$/$$$$
#| $$| $$__  $$| $$|_  $$_/  |  $$  /$$/| $$| $$_  $$_  $$
#| $$| $$  \ $$| $$  | $$     \  $$/$$/ | $$| $$ \ $$ \ $$
#| $$| $$  | $$| $$  | $$ /$$  \  $$$/  | $$| $$ | $$ | $$
#| $$| $$  | $$| $$  |  $$$$//$$\  $/   | $$| $$ | $$ | $$
#|__/|__/  |__/|__/   \___/ |__/ \_/    |__/|__/ |__/ |__/
# ————————————————————————————————————————————————————————

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# ————————
# SETTINGS
# ————————

# language environment
export LANG=fr_FR.UTF-8

# editor
export EDITOR=/usr/bin/nvim

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

# exit i3
exit_i3() {
	killall feh
	i3-msg exit
}

# upgrade st terminal
upgrade_terminal() {
	dir=$(pwd)

	rm -rf /tmp/st
	git clone git://git.suckless.org/st /tmp/st
	cp ~/.config/st/config.h /tmp/st
	cd /tmp/st
	sudo make install
	cd $dir
	rm -rf /tmp/st
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
export SPACESHIP_CHAR_SYMBOL=">"
export SPACESHIP_CHAR_SUFFIX=" "

# host
export SPACESHIP_HOST_PREFIX="$(printf '\u0040')"

# —————
# ALIAS
# —————

# named directories
export dev=~/Documents/Dev

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

# cmake/prog
alias cmakeinit="cmake_build_prepare"

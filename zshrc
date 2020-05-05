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

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

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

#———————————————
#—— UPDATE ST ——
#———————————————

update_st() {
	declare -A PATCHES

	PATCHES[st-xresources-20180309-c5ba9c0.diff]="https://st.suckless.org/patches/xresources/st-xresources-20180309-c5ba9c0.diff"
	PATCHES[st-gruvbox-dark-0.8.2.diff]="https://st.suckless.org/patches/gruvbox/st-gruvbox-dark-0.8.2.diff"
	PATCHES[st-font2-20190416-ba72400.diff]="https://st.suckless.org/patches/font2/st-font2-20190416-ba72400.diff"
	PATCHES[st-autosync-0.8.3.diff]="https://st.suckless.org/patches/sync/st-autosync-0.8.3.diff"
	PATCHES[st-appsync-0.8.3.diff]="https://st.suckless.org/patches/sync/st-appsync-0.8.3.diff"
	PATCHES[st-scrollback-20200419-72e3f6c.diff]="https://st.suckless.org/patches/scrollback/st-scrollback-20200419-72e3f6c.diff"
	PATCHES[st-scrollback-mouse-20191024-a2c479c.diff]="https://st.suckless.org/patches/scrollback/st-scrollback-mouse-20191024-a2c479c.diff"
	PATCHES[st-scrollback-mouse-altscreen-20200416-5703aa0.diff]="https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20200416-5703aa0.diff"

	cwd=$PWD

	rm -rf /tmp/st
	git clone git://git.suckless.org/st /tmp/st

	cd /tmp/st
	for patch url in ${(kv)PATCHES}; do
		curl -O $url
		patch -p1 < $patch
	done

	cp ~/.config/st/config.h $PWD/config.def.h
	sudo make install

	cd $cwd
}

#—————————————
#—— ANTIGEN ——
#—————————————

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

#——————————————————————
#—— HELPER FUNCTIONS ——
#——————————————————————

# exit i3
exit_i3() {
	killall feh
	i3-msg exit
}

#———————————————————
#—— ZSH VARIABLES ——
#———————————————————

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"

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

# named directories
export dev=~/Documents/Dev

# utils
alias mirrupg="sudo reflector --country France --sort rate --age 12 --protocol https --save /etc/pacman.d/mirrorlist"

# update st
alias update_st=update_st

# vpn
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"

# package mgmt
alias sysupg="yay -Syu"
alias sysinstall="yay -S"
alias sysrm="yay -Rcsn --noconfirm"
alias syspkgsrc="yay -Qs"
alias sysclean="yay -Scc && sysrm $(yay -Qtdq)"

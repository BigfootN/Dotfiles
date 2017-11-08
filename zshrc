# ————
# INIT
# ————

# load Xresources
if [ -f ~/.Xresources ]
then
	xrdb ~/.Xresources
fi

# ————————
# SETTINGS
# ————————

# antigen plugin path
ADOTDIR="$HOME/.config/antigen"

# keyboard speed
xset r rate 180 100

# language environment
export LANG=fr_FR.UTF-8

# editor
export EDITOR='atom'

# npm
PATH="$HOME/.node_modules/bin/:$PATH"
export npm_config_prefix=~/.node/modules

# ———————
# ANTIGEN
# ———————

# source antigen
source ~/.config/antigen/antigen.zsh

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
alias pacaur="pacaur --noconfirm --noconfirm"
alias mirrupg="sudo reflector --country 'France' --latest 200 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias vpn_connect="sudo expressvpn connect smart"
alias vpn_disconnect="sudo expressvpn disconnect"

# ——————
# PROMPT
# ——————

function powerline_precmd() {
	PS1="$(~/.config/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
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

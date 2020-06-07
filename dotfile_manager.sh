#!/bin/zsh

. utils/dotfiles.sh
. utils/config.sh
. utils/dependencies.sh

args=("$@")
args_size="$#"

function {
	if [[ "$args_size" -gt 1 ]]; then
		echo "Only 1 argument required!"
	else
		local arg=${args[1]}

		case $arg in
			-s|--save)
				dotfiles_save
				;;
			-d|--deploy)
				dotfiles_deploy
				;;
			-i|--install)
				install
				configure
				;;
			*)
				echo "Option \"$arg\" not recognized!"
				;;
		esac
	fi
}

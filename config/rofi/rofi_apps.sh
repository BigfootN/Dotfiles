#!/bin/zsh

NAUTILUS="\tNautilus"
FIREFOX="\tFirefox"
ALACRITTY="\tAlacritty"
TRANSMISSION="\tTransmission"
VSCODE="\tCode"

case "$@" in
	*Code)
		coproc code
		exit 0
		;;
	*Firefox)
		coproc firefox
		exit 0
		;;
	*Nautilus)
		coproc nautilus
		exit 0
		;;
	*Alacritty)
		coproc alacritty
		exit 0
		;;
	*Transmission)
		coproc transmission-gtk
		exit 0
		;;
esac

echo -e $TRANSMISSION
echo -e $NAUTILUS
echo -e $ALACRITTY
echo -e $FIREFOX
echo -e $VSCODE
#!/bin/zsh

NEMO="\tNemo"
BRAVE="爵\tBrave"
ALACRITTY="\tAlacritty"
TRANSMISSION="\tTransmission"
EASYTAG="\tEasytag"
VSCODE="\tCode"
SPOTIFY="\tSpotify"
INTELLIJ="\tIntellij"

launch_in_term () {
	coproc alacritty --class "$1","$1" -t "$1" -e zsh -c "sleep 0.1 && $1" > /dev/null 2>&1
}

spawn() {
	coproc $1 > /dev/null 2>&1
	exit 0
}

case "$@" in
	*Code)
		coproc code
		exit 0
		;;
	*Brave)
		coproc brave > /dev/null 2>&1
		exit 0
		;;
	*Nemo)
		coproc nemo > /dev/null 2>&1
		exit 0
		;;
	*Intellij)
		coproc _JAVA_AWT_WM_NONREPARENTING=1 intellij-idea-ultimate-edition > /dev/null 2>&1
		exit 0
		;;
	*Alacritty)
		coproc alacritty > /dev/null 2>&1
		exit 0
		;;
	*Transmission)
		coproc transmission-gtk > /dev/null 2>&1
		exit 0
		;;
	*Spotify)
		coproc spotify > /dev/null 2>&1
		exit 0
		;;
	*Easytag)
		spawn easytag
		;;
esac

echo -e $TRANSMISSION
echo -e $NEMO
echo -e $ALACRITTY
echo -e $NEOVIM
echo -e $EASYTAG
echo -e $BRAVE
echo -e $VSCODE
echo -e $SPOTIFY
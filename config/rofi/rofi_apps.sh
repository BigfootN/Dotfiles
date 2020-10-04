#!/bin/zsh

launch_in_term () {
	coproc alacritty --class $1,$1 -t $1 -e zsh -c "sleep 0.1 && $1" > /dev/null 2>&1
	exit 0
}

spawn() {
	coproc $1 > /dev/null 2>&1
	exit 0
}

case "$@" in
	"neovim")
		launch_in_term nvim
		;;
	"firefox")
		coproc firefox
		exit 0
		;;
	"nemo")
		coproc nemo
		exit 0
		;;
	"alacritty")
		coproc alacritty > /dev/null 2>&1
		exit 0
		;;
	"transmission-gtk")
		corproc transmission-gtk > /dev/null 2>&1
		exit 0
		;;
	"skype")
		coproc skypeforlinux > /dev/null 2>&1
		exit 0
		;;
	"easytag")
		spawn easytag
		;;
esac

echo "neovim"
echo "alacritty"
echo "firefox"
echo "nemo"
echo "transmission-gtk"
echo "skype"
echo "easytag"

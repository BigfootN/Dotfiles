#!/bin/zsh

launch_in_kitty () {
	coproc kitty --class=$1 $1 > /dev/null 2>&1
	exit 0
}

case "$@" in
	"ncmpcpp")
		launch_in_kitty "ncmpcpp"
		;;
	"neovim")
		launch_in_kitty "nvim"
		;;
	"firefox")
		firefox
		;;
	"nemo")
		nemo
		;;
	"kitty")
		coproc kitty > /dev/null 2>&1
		;;
	"transmission-gtk")
		transmission-gtk > /dev/null 2>&1
		;;
esac

echo "ncmpcpp"
echo "neovim"
echo "kitty"
echo "firefox"
echo "nemo"
echo "transmission-gtk"

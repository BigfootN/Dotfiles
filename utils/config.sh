#!/bin/zsh

# keyboard layout
KEYBOARD_LAYOUT=de

configure_fonts() {
	wd=$PWD
	cd /etc/fonts/conf.d
	sudo ln -s ../conf.avail/10-sub-pixel-rgb.conf
}

conigure_xorg() {
	sudo nvidia-xconfig
	sudo cp /root/xorg.conf.new /etc/X11/xorg.conf
}

configure_grub() {
	sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	sudo grub-mkconfig -o /boot/grub/grub.config
}

configure_keyboard() {
	sudo setxkbmap $KEYBOARD_LAYOUT
	sudo localectl --no-convert set-x11-keymap $KEYBOARD_LAYOUT
}

configure_clock() {
	sudo timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"
}

configure() {
	configure_fonts
	configure_xorg
	configure_grub
	configure_keyboard
	configure_clock
}

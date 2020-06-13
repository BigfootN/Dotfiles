#!/bin/zsh

# keyboard layout
KEYBOARD_LAYOUT=us

configure_fonts() {
	cwd=$PWD

	cd /etc/fonts/conf.d
	sudo ln -sf ../conf.avail/10-sub-pixel-rgb.conf

	cd "$cwd"
}

conigure_xorg() {
	sudo nvidia-xconfig
	sudo cp /root/xorg.conf.new /etc/X11/xorg.conf
}

configure_grub() {
	sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	sudo grub-mkconfig -o /boot/grub/grub.cfg
}

configure_keyboard() {
	sudo setxkbmap "$KEYBOARD_LAYOUT"
	sudo localectl set-keymap --noconvert "$KEYBOARD_LAYOUT"
}

configure_clock() {
	sudo ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
	sudo hwclock --systohc
	sudo timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"
}

configure_nvim() {
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

configure() {
	configure_fonts
	configure_xorg
	configure_grub
	configure_keyboard
	configure_clock
}

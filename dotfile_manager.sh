#!/bin/zsh

. config_files.sh

declare -a PACKAGES
PACKAGES=(
	"base"
	"base-devel"
	"linux"
	"linux-firmware"
	"neovim"
	"clang"
	"ncmpcpp"
	"mpd"
	"mpc"
	"lightdm"
	"lightdm-webkit-theme-litarvan"
	"git"
	"nerd-fonts-complete"
	"firefox"
	"grub"
	"alsa-utils"
	"feh"
	"reflector"
	"xorg-server"
	"iwd"
	"mesa"
	"awesomewm"
	"nemo"
	"transmission-gtk"
	"dhcpcd"
	"cmake"
	"xorg-xset"
	"picom"
	"adapta-gtk-theme"
	"papirus-icon-theme"
	"wget"
	"vulkan-intel"
	"pacman-contrib"
	"man"
	"betterlockscreen"
	"freetype2-cleartype"
)

# keyboard layout
KEYBOARD_LAYOUT=de

# username
USERNAME=bigfoot

# default shell to use
SHELL=/bin/zsh

source_zshrc() {
	su - $USERNAME -c "mkdir -p ~/.antigen"
	su - $USERNAME -c "curl -L git.io/antigen > ~/.antigen/antigen.zsh"
	su - $USERNAME -c "source ~/.zshrc"
}

configure_mirrors() {
	su - $USERNAME -c "yay -Sy reflector"
	reflector -c France --ipv6 -p https -f 10 > /tmp/mirrors
	sudo mv /tmp/mirrors /etc/pacman.d/mirrorlist
}

copy_files() {
	for git_path in ${(k)CONFIG_FILES}
	do
		local_path=${CONFIG_FILES[$git_path]}
		dir=${local_path%/*}
		su - $USERNAME -c "mkdir -p $dir"
		su - $USERNAME -c "cp -r $git_path $local_path"
	done
}

update_st() {
	declare -A PATCHES

	PATCHES[st-xresources-20180309-c5ba9c0.diff]="https://st.suckless.org/patches/xresources/st-xresources-20180309-c5ba9c0.diff"
	PATCHES[st-gruvbox-dark-0.8.2.diff]="https://st.suckless.org/patches/gruvbox/st-gruvbox-dark-0.8.2.diff"
	PATCHES[st-font2-20190416-ba72400.diff]="https://st.suckless.org/patches/font2/st-font2-20190416-ba72400.diff"
	PATCHES[st-autosync-0.8.3.diff]="https://st.suckless.org/patches/sync/st-autosync-0.8.3.diff"
	PATCHES[st-appsync-0.8.3.diff]="https://st.suckless.org/patches/sync/st-appsync-0.8.3.diff"

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

configure_fonts() {
	wd=$PWD
	cd /etc/fonts/conf.d
	sudo ln -s ../conf.avail/10-sub-pixel-rgb.conf
}

configure_xorg() {
	sudo Xorg :0 -configure
	sudo cp /root/xorg.conf.new /etc/X11/xorg.conf
}

configure_grub() {
	grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.config
}

configure_keyboard() {
	sudo setxkbmap $KEYBOARD_LAYOUT
	sudo localectl --no-convert set-x11-keymap $KEYBOARD_LAYOUT
}

install_yay() {
	cwd=$PWD

	pacman -S git
	rm -rf /tmp/yay
	git clone https://aur.archlinux.org/yay.git
	cd /tmp/yay
	makepkg -si

	cd $cwd
}

create_user() {
	pacman -S nano sudo
	export EDITOR=nano
	useradd -m -G wheel,audio,video -s $SHELL $USERNAME
	visudo
}

configure_time() {
	timedatectl set-timezone Europe/Paris
}

install_packages() {
	packages_str=""

	for package in $PACKAGES
	do
		packages_str="${packages_str} $package"
	done

	su - $USERNAME -c "sysinstall $packages_str"
}

parse_arguments() {
	if ["$#" -ne 2]; then
		{echo "Only 1 argument required!" 2>&1 1>/dev/null} | cat
	else
		case "$1" in
			"install_all")
				install_all()
				;;
			"install_files")
				install_files()
				;;
			"push"
				push_files()
				;;
		esac
	fi
}

install_yay
configure_mirrors
update_st
create_user
install_packages
copy_files
configure_keyboard
configure_time
configure_xorg

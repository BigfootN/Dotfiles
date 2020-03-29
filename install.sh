#!/bin/zsh

. config_files.sh

declare -a PACKAGES
PACKAGES=(
    "base"
    "base-devel"
    "linux"
    "linux-firmware"
    "visual-studio-code-bin"
    "python-i3ipc"
    "clang"
    "gnome-terminal"
    "lightdm"
    "lightdm-webkit-theme-litarvan"
    "git"
    "nerd-fonts-complete"
    "firefox"
    "polybar"
    "grub"
    "alsa-utils"
    "feh"
    "xorg-server"
    "iwd"
    "mesa"
    "i3-gaps"
    "nemo"
    "transmission-gtk"
    "dhcpcd"
    "cmake"
    "xorg-xset"
    "picom"
    "adapta-gtk-theme"
    "papirus-icon-theme"
    "spotify"
    "wget"
    "vulkan-intel"
    "python-dbus"
    "pacman-contrib"
    "man"
    "betterlockscreen"
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
    servers=$(curl -s "https://www.archlinux.org/mirrorlist/?country=FR&protocol=https&ip_version=6" | sed -e 's/^#Server/Server/' -e '/^#/d')
    echo $servers > mirrorlist
    mv mirrorlist /etc/pacman.d/mirrorlist
}

copy_files() {
    for git_path in ${(k)CONFIG_FILES}
    do
        local_path=${CONFIG_FILES[$git_path]}
        dir=${local_path%/*}
        su - $USERNAME -c "mkdir -p $dir"
        su - $USERNAME -c "cp $git_path $local_path"
    done

    su - $USERNAME -c "dconf load /org/gnome/terminal/ < $PWD/config/gnome-terminal/settings.txt"
    su - $USERNAME -c "cat config/code/extensions.list | xargs -L 1 code --install-extension"
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

create_user() {
    pacman -S nano sudo
    export EDITOR=nano
    useradd -m -G wheel,audio,video -s $SHELL $USERNAME
    visudo
}

configure_time() {
    timedatectl set-timezone Europe/Paris
}

install_yay() {
    yay_url=https://aur.archlinux.org/yay.git
    yay_wd=/tmp/yay

    cwd=$PWD
    mkdir -p $yay_wd
    git clone $yay_url $yay_wd
    cd $yay_wd
    makepkg -si
    cd $cwd
    rm -rf $yay_wd
}

install_packages() {
    packages_str=""

    for package in $PACKAGES
    do
        packages_str="${packages_str} $package"
    done

    su - $USERNAME -c "sysinstall $packages_str"
}

install_yay_body=`declare -f install_yay`

configure_mirrors
create_user
su - $USERNAME -c "$install_yay_body; install_yay"
install_packages
copy_files
configure_keyboard
configure_time
configure_xorg
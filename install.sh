#!/bin/zsh

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
)

declare -A CONFIG_FILES
CONFIG_FILES=(
    ["config/clang-format/clang-format"]="~/.config/clang-format/clang-format"
    ["config/code/settings.json"]="~/.config/Code/User/settings.json"
    ["config/gtk-3.0/settings.ini"]="~/.config/gtk-3.0/settings.ini"
    ["config/gtk-3.0/gtk.css"]="~/.config/gtk-3.0/gtk.css"
    ["config/i3/config"]="~/.config/i3/config"
    ["config/i3/goto_workspace.py"]="~/.config/i3/goto_workspace.py"
    ["config/i3/move_container.py"]="~/.config/i3/move_container.py"
    ["config/i3/volume.sh"]="~/.config/i3/volume.sh"
    ["config/picom/picom.conf"]="~/.config/picom/picom.conf"
    ["config/polybar/config"]="~/.config/polybar/config"
    ["config/polybar/musicinfo.py"]="~/.config/polybar/launch"
    ["config/polybar/updates.sh"]="~/.config/polybar/updates.sh"
)

# keyboard layout
KEYBOARD_LAYOUT=de

# username
USERNAME=bigfoot

# default shell to use
SHELL=/bin/zsh

source_zshrc() {
    mkdir -p ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
    source ~/.zshrc
}

configure_mirrors() {
    servers=$(curl -s "https://www.archlinux.org/mirrorlist/?country=FR&protocol=https&ip_version=6" | sed -e 's/^#Server/Server/' -e '/^#/d')
    echo $servers > mirrorlist
    sudo mv mirrorlist /etc/pacman.d/mirrorlist
}

configure_shell() {
    chsh -s $SHELL $USERNAME
}

copy_files() {
    for git_path in ${(k)CONFIG_FILES}
    do
        local_path=${CONFIG_FILES[$git_path]}
        dir=${local_path%/*}
        mkdir -p $dir
        cp $git_path $local_path
    done

    dconf load /org/gnome/terminal/ < $PWD/config/gnome-terminal/settings.txt
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

    sysinstall $packages_str
}

configure_mirrors
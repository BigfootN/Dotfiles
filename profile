sxhkd &
xset +fp /usr/share/fonts/local
xset fp rehash
rm -rf /tmp/panel-fifo
mkfifo /tmp/panel-fifo
~/.config/bspwm/panel/panel.sh &
feh --bg-fill /home/scriptor/Images/simple_bubbles.png &
/etc/X11/xinit/xinitrc.d/30-dbus.sh
udiskie &
compton -b

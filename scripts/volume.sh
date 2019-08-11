#!/bin/sh

case $1 in
	up)
		/usr/bin/amixer -q -c 0 sset 'Master' 5%+
		;;
	down)
		/usr/bin/amixer -q -c 0 sset 'Master' 5%-
		;;
	*)
		/usr/bin/amixer -q -c 0 sset 'Master' toggle
		;;
esac

CURVOL=`amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $2 }'`
VOL_ICON=$(echo -e '\ufa7d')

notify-send -u low -a "volume" -i "$VOL_ICON" "  Volume: $CURVOL" 

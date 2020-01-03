#!/bin/sh

case $1 in
	up)
		/usr/bin/amixer sset Master 5%+
		;;
	down)
		/usr/bin/amixer sset Master 5%-
		;;
	*)
		/usr/bin/amixer sset Master toggle
		;;
esac

CURVOL=`amixer sget Master | grep 'Right:' | awk -F '[][]' '{ print $2 }'`
VOL_ICON=$(echo -e '\ufa7d')
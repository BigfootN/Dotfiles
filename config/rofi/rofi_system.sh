#!/bin/zsh

SUSPEND="鈴"
SHUTDOWN=""
LOGOUT=""
RESTART=""

case "$@" in
	$SUSPEND)
		systemctl suspend
		exit 0
		;;
	$LOGOUT)
		coproc i3-msg exit
		exit 0
		;;
	$SHUTDOWN)
		systemctl poweroff
		exit 0
		;;
	$RESTART)
		systemctl reboot
		exit 0
		;;
esac

echo -e $SUSPEND
echo -e $SHUTDOWN
echo -e $RESTART
echo -e $LOGOUT

#!/bin/zsh

SUSPEND="鈴"
SHUTDOWN=""
LOGOUT=""
RESTART=""

case "$@" in
	$SUSPEND)
		systemctl suspend > /dev/null 2&>1
		exit 0
		;;
	$LOGOUT)
		coproc bspc quit > /dev/null 2&>1
		exit 0
		;;
	$SHUTDOWN)
		systemctl poweroff > /dev/null 2&>1
		exit 0
		;;
	$RESTART)
		systemctl reboot > /dev/null 2&>1
		exit 0
		;;
esac

echo -e $SUSPEND
echo -e $SHUTDOWN
echo -e $RESTART
echo -e $LOGOUT

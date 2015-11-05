basedir=$( dirname "${BASH_SOURCE[0]}" )
source $basedir/config

function init_fifo {
rm -rf $FIFO
mkfifo $FIFO
}

function desktop {
current_desk=1
while true; do
    #current_desk=$(bspc -D -d)
    desk_ret=""
    case "$current_desk" in
        "1" )
            desk_ret="$SEL_DESKTOP_COL$DESKTOP_1%{-u}%{B-}$DESKTOP_2$DESKTOP_3$DESKTOP_4$DESKTOP_5"
            ;;
        "2" )
            desk_ret="$DESKTOP_1$SEL_DESKTOP_COL$DESKTOP_2%{-u}%{B-}$DESKTOP_3$DESKTOP_4$DESKTOP_5"
            ;;
        "3" )
            desk_ret="$DESKTOP_1$DESKTOP_2$SEL_DESKTOP_COL$DESKTOP_3%{-u}%{B-}$DESKTOP_4$DESKTOP_5"
            ;;
        "4" )
            desk_ret="$DESKTOP_1$DESKTOP_2$DESKTOP_3$SEL_DESKTOP_COL$DESKTOP_4%{-u}%{B-}$DESKTOP_5"
            ;;
        "5" )
            desk_ret="$DESKTOP_1$DESKTOP_2$DESKTOP_3$DESKTOP_4$SEL_DESKTOP_COL$DESKTOP_5%{-u}%{B-}"
            ;;
    esac

    echo -e "(desk)%{F-}%{B-}$desk_ret"
    current_desk=$(($current_desk % 5 + 1))
    echo "current_desk = $current_desk"
    sleep 2
done
}

function cpu_calc {
while true; do
    perc_cpu=$(mpstat | grep all | awk '{print $3,"%"}' | sed 's/ //g')
    cpu="%{T2}$CPU_ICON %{T3}$perc_cpu"
    echo -e "(cpu)%{F$CPU_COLOR}$cpu%{B-}"
    sleep 1
done
}

function mem_calc {
while true; do
    perc_mem=$(free -mh | grep -n 2 | awk '{print $3}')
    mem="%{T2}$RAM_ICON %{T3}$perc_mem"
    echo -e "(mem)%{F$RAM_COLOR}$mem%{B-}"
    sleep 1
done
}

function cpu_temp {
while true; do
    cpu_temp=$(sensors | grep Physical | awk '{print $4}' | sed 's/+//g')
    cpu="%{T2}$CPU_TEMP %{T3}$cpu_temp"
    echo -e "(tcpu)%{F$TEMP_COLOR}$cpu%{B-}"
    sleep 1
done
}

function time_stdout {
while true; do
    time=$(date +%H:%M)
    echo -e "(time)%{F$CLOCK_COLOR}%{T2}$CLOCK_ICON %{T3}$time"
    sleep 1
done
}

function music_stdout {
music=$(mpc current)
while true; do
    music_state=$(mpc status | sed -n '2p' | awk '{ print $1 }')
    if [[ $music_state == "[paused]" ]]; then
        music="%{T2}\ue059 %{T3}$music %{T3}\ue05c"
    elif [[ $music_state == "[playing]" ]]; then
        music="%{T2}\ue058 %{T3}$music %{T3}\ue05c"
    else
        music="%{T2}\ue057"
    fi
    echo -e "(music)%{B-}$music%{B-}"
    mpc idle
    music=$(mpc current)
done
}

function time {
while true; do
    cpu_temp=$(date +%H:%M)
    echo -e ""
done
}

function init {
init_fifo
time_stdout > "$FIFO" &
cpu_calc > "$FIFO" &
mem_calc > "$FIFO" &
cpu_temp > "$FIFO" &
music_stdout > "$FIFO" &
desktop > "$FIFO" &
}

bar_geometry="$PANEL_LENGTH""x""$PANEL_HEIGHT+0+0"

#--------------
# LAUNCH PANEL
#--------------

# launch the main function
init

cat "$FIFO" | while read -r line; do
case $line in
    "(cpu)"*)
        cpu=${line:5}
        ;;
    "(mem)"*)
        mem=${line:5}
        ;;
    "(tcpu)"*)
        tcpu=${line:6}
        ;;
    "(music)"*)
        music=${line:7}
        ;;
    "(time)"*)
        time=${line:6}
        ;;
    "(desk)"*)
        desk=${line:6}
        ;;
esac
echo -e "%{l}$desk%{B$PANEL_BG_COL}%{c}$music%{r}  $tcpu  $mem  $cpu  $time  "
done | lemonbar -o -1 -p -u 3 -f "$FONT_DESKTOP_ICON" -f "$FONT_ICONS" -f "$FONT_TEXT" -g "$bar_geometry" -B "#414040"

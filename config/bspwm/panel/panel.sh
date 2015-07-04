basedir=$( dirname "${BASH_SOURCE[0]}" )
source $basedir/config

rm -rf $FIFO
mkfifo $FIFO


function cpu_calc {
    while true; do
        perc_cpu=$(mpstat | grep all | awk '{print $3,"%"}' | sed 's/ //g')
        cpu=" %{T3}\ue020 %{T1}$perc_cpu \020"
        echo -e "(cpu)%{B$RAM_BACKGROUND}%{F$CPU_BACKGROUND}$LEFT_ARROW%{B$CPU_BACKGROUND}%{F$WHITE}$cpu%{B-}"
        sleep 1
    done
}

function mem_calc {
    while true; do
        perc_mem=$(free -mh | grep -n 2 | awk '{print $3}')
        mem=" %{T3}\ue132 %{T1}$perc_mem \020"
        echo -e "(mem)%{B$TEMP_BACKGROUND}%{F$RAM_BACKGROUND}$LEFT_ARROW%{F$WHITE}%{B$RAM_BACKGROUND}$mem%{B-}"
        sleep 1
    done
}

function cpu_temp {
    while true; do
        cpu_temp=$(sensors | grep Physical | awk '{print $4}' | sed 's/+//g')
        cpu=" %{T3}\ue01d %{T1}$cpu_temp \020"
        echo -e "(tcpu)%{F$TEMP_BACKGROUND}$LEFT_ARROW%{F$WHITE}%{B$TEMP_BACKGROUND}$cpu%{B-}"
        sleep 1
    done
}

function music_stdout {
    music=$(mpc current)
    music=" %{T3}\ue0fe %{T1}$music \020"
    echo -e "(music)%{B-}%{F$WHITE}%{A:music.sh:}$music%{A}%{B-}"
    while true; do
        music=$(mpc current --wait)
        music=" %{T3}\ue0fe %{T1}$music \020"
        echo -e "(music)%{B-}%{F$WHITE}$music%{B-}"
    done
}

function time {
    while true; do
        cpu_temp=$(date +%H:%M)
        echo -e ""
    done
}

cpu_calc > "$FIFO" &
mem_calc > "$FIFO" &
cpu_temp > "$FIFO" &
music_stdout > "$FIFO" &

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
    esac
    echo -e "%{c}$music%{r}$tcpu$mem$cpu"
done | lemonbar -p -f "Inconsolata for Powerline-11" -f "Inconsolata for Powerline-14" -f "$FONT_ICONS" -g "1880x20+20+10" -o -2 -o 0 -o -3 -B#414040

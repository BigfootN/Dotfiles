#!/usr/bin/bash

RED="%{F#F70303}"
BLUE="%{F#3217AA}"
GREEN="%{F#02B344}"

ICONS_COLOR="$RED"
TEXT_COLOR="%{F#FFB856}"

# font
FONT1="-*-stlarch-medium-r-*-*-11-*-*-*-*-*-*-*"
FONT2="-*-terminus-medium-r-*-*-12-*-*-*-*-*-iso10646-*"

function print_date {
    while true; do
        echo "(date)$ICONS_COLOR\uE016 $TEXT_COLOR$(date "+%H:%M")"
        sleep 1;
    done
}

function print_current_song {
    while true; do
        CURR_SONG=$(mpc current -f "%artist% - %title%")
        if [ -z "$CURR_SONG" ]; then
            CURR_SONG="arrêté"
        fi
        echo "(music)$ICONS_COLOR\uE0EC $TEXT_COLOR$CURR_SONG"
        sleep 1;
    done
}

function print_mem_used {
    while true; do
        total_memory=$(free -mb | grep -n 2 | awk -F " *" '{ print $2 }' -)
        used_memory=$(free -mb | grep -n 2 | awk -F " *" '{ print $3 }' -)
        perc_mem=$(( used_memory*100 ))
        perc_mem=$(( perc_mem/total_memory ))
        echo "(ram)$ICONS_COLOR\uE146 $TEXT_COLOR$perc_mem%%"
        sleep 1;
    done
}

function print_proc_used {
    while true; do
        proc_perc=$(mpstat 1 1 | grep "Moyenne" | awk -F ":" '{ print $2 }' | awk -F " *" '{print $3}')
        echo "(cpu)$ICONS_COLOR \uE0C1 $TEXT_COLOR$proc_perc%%"
        sleep 1;
    done
}

function print_desktop {
    colors="$ICONS_COLOR"
    while true; do
        desktop_num=$(bspc query -D -d)
        case "$desktop_num" in
            "1")
                desktop_echo="%{B#767171}  ●  %{B-}   ○   ○   ○"
                ;;
            "2")
                desktop_echo="○   %{B#767171}  ●  %{B-}   ○   ○"
                ;;
            "3")
                desktop_echo="○   ○   %{B#767171}  ●  %{B-}   ○"
                ;;
            "4")
                desktop_echo="○   ○   ○   %{B#767171}  ●  %{B-}"
                ;;
        esac
        echo -e "(desk)%{c}$colors$desktop_echo"
        sleep 0.2;
    done
}

print_date > "$PANEL_FIFO" &
print_current_song > "$PANEL_FIFO" &
print_mem_used > "$PANEL_FIFO" &
print_proc_used > "$PANEL_FIFO" &
print_desktop > "$PANEL_FIFO" &

# test
cat "$PANEL_FIFO" | while read -r line; do
    case $line in
        "(date)"*)
            date=${line:6}
            ;;
        "(music)"*)
            music=${line:7}
            ;;
        "(ram)"*)
            ram=${line:5}
            ;;
        "(cpu)"*)
            cpu=${line:5}
            ;;
        "(desk)"*)
            desk=${line:6}
            ;;
    esac
    echo -e "%{c}$ICONS_COLOR$desk%{B-}%{r} $cpu | $ram | $music | $date"
    echo ""
done | lemonbar -p -g "1920x20+0+0" -B#414040 -f "$FONT1" -f "$FONT2"

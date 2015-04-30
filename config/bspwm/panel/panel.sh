#!/usr/bin/bash

RED="%{F#F70303}"
BLUE="%{F#3217AA}"
GREEN="%{F#02B344}"

ICONS_COLOR="$RED"
TEXT_COLOR="%{F#FFB856}"

# font
FONT1="-*-terminus-*-*-*-12-*-*-*-*-*-*-*-*"
FONT2="-*-stlarch-medium-r-*-*-11-*-*-*-*-*-*-*"
FONT3="-*-terminus-medium-r-*-*-12-*-*-*-*-*-iso10646-*"
FONT4="-misc-fixed-medium-r-normal-*-13-120-75-75-C-70-iso10646-1"
FONT5="xft:Inconsolata for Powerline:size=9"

function print_date {
    while true; do
        echo "(date)$TEXT_COLOR$(date "+%H:%M")"
        sleep 1;
    done
}

function print_current_song {
    while true; do
        CURR_SONG=$(mpc current -f "%artist% - %title%")
        if [ -z "$CURR_SONG" ]; then
            CURR_SONG="arrêté"
        fi
        echo "(music)$TEXT_COLOR$CURR_SONG"
        sleep 1;
    done
}

function print_mem_used {
    while true; do
        total_memory=$(free -mb | grep -n 2 | awk -F " *" '{ print $2 }' -)
        used_memory=$(free -mb | grep -n 2 | awk -F " *" '{ print $3 }' -)
        perc_mem=$(( used_memory*100 ))
        perc_mem=$(( perc_mem/total_memory ))
        echo "(ram)$TEXT_COLOR$perc_mem%%"
        sleep 1;
    done
}

function print_proc_used {
    while true; do
        proc_perc=$(mpstat 1 1 | grep "Moyenne" | awk -F ":" '{ print $2 }' | awk -F " *" '{print $3}')
        echo "(cpu)$TEXT_COLOR$proc_perc%%"
        sleep 1;
    done
}

function print_desktop {
    colors="$ICONS_COLOR"
    while true; do
        desktop_num=$(bspc query -D -d)
        case "$desktop_num" in
            "1")
                desktop_echo="●   ○   ○   ○"
                ;;
            "2")
                desktop_echo="○   ●   ○   ○"
                ;;
            "3")
                desktop_echo="○   ○   ●   ○"
                ;;
            "4")
                desktop_echo="○   ○   ○   ●"
                ;;
        esac
        echo -e "(desk)$colors$desktop_echo"
        sleep 0.2;
    done
}

#print_current_song > "$PANEL_FIFO" &
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
    echo -e "%{c}$ICONS_COLOR$desk%{B-}%{r}$ICONS_COLOR \uE0C1 $cpu |$ICONS_COLOR \uE146 $ram |$ICONS_COLOR \uE0EC $music |$ICONS_COLOR \uE016 $date"
    echo ""
done | lemonbar -p -g "1920x20+0+0" -B#494844 -f "$FONT5"

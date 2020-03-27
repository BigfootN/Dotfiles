#!/bin/zsh

killall -q polybar

polybar main >> /tmp/polybar.main.log 2>&1 &
#!/bin/bash

INTERNAL=$(xrandr | awk '/ connected primary/ {print $1}')
[ -z "$INTERNAL" ] && INTERNAL=$(xrandr | awk '/ connected/ {print $1}' | head -n1)

EXTERNAL=$(xrandr | awk '/ connected/ {print $1}' | grep -v "$INTERNAL" | head -n1)

if [ -z "$EXTERNAL" ]; then
    notify-send "Display" "No external monitor detected"
    exit 1
fi

CHOICE=$(printf "󰍹 Mirror\n󰍺 Extend Right\n󰌢 Internal Only\n󰍻 External Only" \
    | rofi -dmenu -i -p "Display")

case "$CHOICE" in
    *Mirror)
        xrandr --output "$EXTERNAL" --auto --same-as "$INTERNAL"
        notify-send "Display" "Mirror mode enabled"
        ;;
    *Extend*)
        xrandr --output "$EXTERNAL" --auto --right-of "$INTERNAL"
        notify-send "Display" "Extend mode enabled"
        ;;
    *Internal*)
        xrandr --output "$EXTERNAL" --off
        notify-send "Display" "Internal only mode enabled"
        ;;
    *External*)
        xrandr --output "$INTERNAL" --off
        xrandr --output "$EXTERNAL" --auto
        notify-send "Display" "External only mode enabled"
        ;;
esac

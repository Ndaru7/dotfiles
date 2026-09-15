#!/bin/bash

case $BLOCK_BUTTON in
    1) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
esac

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1)
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
    echo "MUTED"
else
    echo "$VOLUME"
fi

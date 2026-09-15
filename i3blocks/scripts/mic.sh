#!/bin/bash

case $BLOCK_BUTTON in
    1) pactl set-source-mute @DEFAULT_SOURCE@ toggle ;;
esac

MUTED=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
    echo "MUTED"
else
    echo "ON"
fi

#!/bin/bash

case "$BLOCK_BUTTON" in
    1)
        playerctl play-pause
        ;;
    4)
        playerctl next
        ;;
    5)
        playerctl previous
        ;;
esac

STATUS=$(playerctl status 2>/dev/null)

if [ $? -ne 0 ]; then
    echo "󰝛 No Music"
    exit 0
fi

ARTIST=$(playerctl metadata artist)
TITLE=$(playerctl metadata title)

case "$STATUS" in
    Playing)
        echo "󰐊 $ARTIST - $TITLE"
        ;;
    Paused)
        echo "󰏤 $ARTIST - $TITLE"
        ;;
esac

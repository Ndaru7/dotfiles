#!/bin/bash

STATE_FILE="/tmp/i3blocks_time_mode"

# Toggle mode saat diklik
if [ "$BLOCK_BUTTON" = "1" ]; then
    if [ -f "$STATE_FILE" ]; then
        rm "$STATE_FILE"
    else
        touch "$STATE_FILE"
    fi
fi

# Tampilkan output
if [ -f "$STATE_FILE" ]; then
    date '+%A, %d %B %Y | %H:%M:%S'
else
    date '+%H:%M:%S'
fi

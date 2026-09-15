#!/bin/bash

TEMP=$(sensors | awk '/Package id 0:/ {gsub("\\+|°C","",$4); print int($4)}')

if [ -z "$TEMP" ]; then
    echo "N/A"
    exit
fi

if [ "$TEMP" -ge 80 ]; then
    COLOR="#ff0000"
elif [ "$TEMP" -ge 60 ]; then
    COLOR="#ffaa00"
else
    COLOR="#ffffff"
fi

echo "$TEMP°C"
echo "$TEMP°C"
echo "$COLOR"

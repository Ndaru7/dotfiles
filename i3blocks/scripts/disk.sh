#!/bin/bash

USED=$(df -h / | awk 'NR==2 {print $3}')
TOTAL=$(df -h / | awk 'NR==2 {print $2}')
PERCENT=$(df -h / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [ "$PERCENT" -ge 90 ]; then
    COLOR="#ff0000"
elif [ "$PERCENT" -ge 75 ]; then
    COLOR="#ffaa00"
else
    COLOR="#a6e3a1"
fi

echo " ${USED}/${TOTAL}"
echo " ${USED}/${TOTAL}"
echo "$COLOR"

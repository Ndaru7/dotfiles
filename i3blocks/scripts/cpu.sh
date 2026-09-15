#!/bin/bash

ICON=
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

PREV_IDLE=$((idle + iowait))
PREV_TOTAL=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 0.5

read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

IDLE=$((idle + iowait))
TOTAL=$((user + nice + system + idle + iowait + irq + softirq + steal))

DIFF_IDLE=$((IDLE - PREV_IDLE))
DIFF_TOTAL=$((TOTAL - PREV_TOTAL))
USAGE=$((100 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL))

if [ "$USAGE" -ge 80 ]; then
    COLOR="#ff0000"
elif [ "$USAGE" -ge 60 ]; then
    COLOR="#ffaa00"
else
    COLOR="#a6e3a1"
fi

echo "$ICON ${USAGE}%"
echo "$ICON ${USAGE}%"
echo "$COLOR"

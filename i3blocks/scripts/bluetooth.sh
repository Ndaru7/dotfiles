#!/bin/bash

case $BLOCK_BUTTON in
    1)
        STATE=$(bluetoothctl show | awk '/Powered:/ {print $2}')

        if [ "$STATE" = "yes" ]; then
            bluetoothctl power off >/dev/null 2>&1
        else
            bluetoothctl power on >/dev/null 2>&1
        fi
        ;;
esac

POWER=$(bluetoothctl show | awk '/Powered:/ {print $2}')

if [ "$POWER" = "yes" ]; then
    DEVICE=$(bluetoothctl info | awk -F': ' '/Name:/ {print $2}' | head -n1)

    if [ -n "$DEVICE" ]; then
        echo "ON $DEVICE"
    else
        echo "ON"
    fi
else
    echo "OFF"
fi

#!/bin/bash

IFACE=$(ip route | awk '/default/ {print $5}' | head -n1)
WIFI=
LAN=󰌗
OFFLINE=

if [ -z "$IFACE" ]; then
    echo "$OFFLINE"
    exit
fi

TYPE=$(cat /sys/class/net/$IFACE/type)

# Wireless
if [ "$TYPE" = "1" ] && iw dev "$IFACE" info >/dev/null 2>&1; then
    SSID=$(iw dev "$IFACE" link | awk -F': ' '/SSID/ {print $2}')

    if [ -n "$SSID" ]; then
        echo "$WIFI $SSID"
    else
        echo "$WIFI"
    fi

# Wired
else
    echo "$LAN"
fi

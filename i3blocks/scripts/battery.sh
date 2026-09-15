#!/bin/bash

CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity)
STATUS=$(cat /sys/class/power_supply/BAT1/status)

echo "$STATUS $CAPACITY%"

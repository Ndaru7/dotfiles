#!/bin/bash

FILE="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"

mkdir -p "$HOME/Pictures/Screenshots"

maim -s "$FILE"

notify-send "Screenshot" "Saved: $(basename "$FILE")"

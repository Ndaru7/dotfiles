#!/bin/bash

grim /tmp/lockscreen.png
magick /tmp/lockscreen.png -blur 0x8 /tmp/lockscreen-blur.png
swaylock -i /tmp/lockscreen-blur.png

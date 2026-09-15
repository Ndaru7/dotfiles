#!/bin/bash

chosen=$(printf "Lock\nLogout\nSuspend\nReboot\nShutdown" | rofi -dmenu -i -p "Power")

case "$chosen" in
    Lock)
        $HOME/.config/i3/lock.sh
        ;;
    Logout)
        i3-msg exit
        ;;
    Suspend)
        systemctl suspend
        ;;
    Reboot)
        systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
esac

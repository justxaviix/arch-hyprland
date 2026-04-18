#!/usr/bin/env bash
# powermenu.sh — rofi power menu

LOCK="  Lock"
SUSPEND="  Suspend"
REBOOT="  Reboot"
SHUTDOWN="  Shutdown"
EXIT="  Exit Hyprland"

CHOICE=$(printf "%s\n%s\n%s\n%s\n%s" \
    "$LOCK" "$SUSPEND" "$REBOOT" "$SHUTDOWN" "$EXIT" | \
    rofi -dmenu \
        -p "  Power" \
        -theme ~/.config/rofi/themes/powermenu.rasi \
        -no-custom \
        -i)

case "$CHOICE" in
    "$LOCK")     hyprlock ;;
    "$SUSPEND")  systemctl suspend ;;
    "$REBOOT")   systemctl reboot ;;
    "$SHUTDOWN") systemctl poweroff ;;
    "$EXIT")     hyprctl dispatch exit ;;
esac

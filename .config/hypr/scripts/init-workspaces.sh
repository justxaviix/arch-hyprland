#!/usr/bin/env bash
# init-workspaces.sh — force all workspaces into existence

sleep 2

# Create each workspace by switching to it — this registers it with Hyprland
# DVI-D-1 workspaces first
hyprctl dispatch focusmonitor DVI-D-1
for ws in 1 2 3 4 5; do
    hyprctl dispatch workspace "$ws"
    sleep 0.15
done

# HDMI-A-4 workspaces
hyprctl dispatch focusmonitor HDMI-A-4
for ws in 6 7 8 9 10; do
    hyprctl dispatch workspace "$ws"
    sleep 0.15
done

# Now pin each workspace to its monitor
for ws in 1 2 3 4 5; do
    hyprctl dispatch moveworkspacetomonitor "$ws DVI-D-1"
done
for ws in 6 7 8 9 10; do
    hyprctl dispatch moveworkspacetomonitor "$ws HDMI-A-4"
done

# Return to defaults
hyprctl dispatch focusmonitor DVI-D-1
hyprctl dispatch workspace 1
hyprctl dispatch focusmonitor HDMI-A-4
hyprctl dispatch workspace 6

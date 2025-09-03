#!/bin/bash

# Get the current input source
notify-send -i kitty "Monitor" "Checking used port"
current_source=$(ddcutil -d 2 getvcp 60 --brief)

# Check if DisplayPort (x11) is active
if [[ $current_source == *"x11"* ]]; then
    # Switch to HDMI
    notify-send -i kitty "Monitor" "Switching to DisplayPort"
    ddcutil -d 2 setvcp 60 0x0f
# Check if HDMI (x0f) is active
elif [[ $current_source == *"x0f"* ]]; then
    # Switch to DisplayPort
    notify-send -i kitty "Monitor" "Switching to HDMI"
    ddcutil -d 2 setvcp 60 0x11
    sleep 2
    hyprctl dispatch workspace 3
else
    echo "Unknown input source detected: $current_source"
fi

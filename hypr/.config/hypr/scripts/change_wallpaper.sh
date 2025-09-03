#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
RIGHT_MONITOR="HDMI-A-1"
LEFT_MONITOR="DP-2"

while true; do
    # Get currently loaded wallpapers and extract current number
    LOADED_WALLPAPERS=$(hyprctl hyprpaper listloaded)
    CURRENT_LEFT=$(echo "$LOADED_WALLPAPERS" | grep "/l" | head -n 1)
    CURRENT_RIGHT=$(echo "$LOADED_WALLPAPERS" | grep "/r" | head -n 1)
    CURRENT_NUM=$(basename "$CURRENT_LEFT" 2>/dev/null | grep -o '[0-9]')

    # Pick a random number from 1-8 that isn't the current one
    AVAILABLE_NUMS=(1 2 3 4 5 6 7 8)
    NEW_NUM=${AVAILABLE_NUMS[$RANDOM % 8]}

    # Make sure we don't pick the same number
    while [[ "$NEW_NUM" == "$CURRENT_NUM" && "$CURRENT_NUM" != "" ]]; do
        NEW_NUM=${AVAILABLE_NUMS[$RANDOM % 8]}
    done

    # Set wallpapers for each monitor
    LEFT_WALLPAPER="$WALLPAPER_DIR/l$NEW_NUM.png"
    RIGHT_WALLPAPER="$WALLPAPER_DIR/r$NEW_NUM.png"

    # Preload new wallpapers
    hyprctl hyprpaper preload "$LEFT_WALLPAPER"
    hyprctl hyprpaper preload "$RIGHT_WALLPAPER"

    # Set wallpapers
    hyprctl hyprpaper wallpaper "$LEFT_MONITOR,$LEFT_WALLPAPER"
    hyprctl hyprpaper wallpaper "$RIGHT_MONITOR,$RIGHT_WALLPAPER"

    hyprctl hyprpaper unload all

    sleep 60
done

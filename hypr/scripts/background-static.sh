#!/bin/sh

WALLPAPER_DIR="$HOME/Pictures/background/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

sleep 10

while true; do
    # Get a random wallpaper that is not the current one
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

    # Apply the selected wallpaper
    hyprctl hyprpaper wallpaper , "$WALLPAPER"
    sleep 60
done

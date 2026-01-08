#!/bin/bash

wallpaper_dir=~/Pictures/background/

while true; do
    feh --recursive --randomize --bg-max ${wallpaper_dir}
    sleep 30
done

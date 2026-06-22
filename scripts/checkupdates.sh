#!/bin/sh

numupdate=$(checkupdates | wc -l)
if [ $numupdate -ge 1 ]; then
    notify-send "New update available!" "System has $numupdate new packages." --icon=dialog-information
fi

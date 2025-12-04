#!/bin/bash
# Toggle between hyprscroller (scrolling) and dwindle layouts

current=$(hyprctl getoption general:layout -j | jq -r '.str')

if [ "$current" = "scrolling" ]; then
    hyprctl keyword general:layout dwindle
    notify-send "Layout" "Switched to Dwindle"
else
    hyprctl keyword general:layout scrolling
    notify-send "Layout" "Switched to Scrolling"
fi

#!/usr/bin/env bash

THEME_STATE="$HOME/.config/hypr/.current-theme"

# Create state file with default theme if it doesn't exist
if [ ! -f "$THEME_STATE" ]; then
    echo "everforest" > "$THEME_STATE"
fi

# Read current theme
CURRENT_THEME=$(cat "$THEME_STATE")

# Launch waybar with the saved theme
case $CURRENT_THEME in
    "nightowl")
        ~/.config/waybar/launch.sh --nightowl &
        ;;
    "everforest")
        ~/.config/waybar/launch.sh --everforest &
        ;;
    "catppuccin-mocha")
        ~/.config/waybar/launch.sh &
        ;;
    *)
        ~/.config/waybar/launch.sh --everforest &
        ;;
esac

#!/usr/bin/env bash

THEME_DIR="$HOME/.config"
THEMES=("catppuccin-mocha" "everforest" "nightowl")

# Use rofi to select theme
SELECTED_THEME=$(printf '%s\n' "${THEMES[@]}" | rofi -dmenu -i -p "Select Theme" -theme-str 'window {width: 400px;}')

if [ -z "$SELECTED_THEME" ]; then
    exit 0
fi

# Update Kitty theme
KITTY_CONF="$THEME_DIR/kitty/kitty.conf"
case $SELECTED_THEME in
    "catppuccin-mocha")
        sed -i 's|^include themes/.*\.conf|include themes/catppuccin-mocha.conf|' "$KITTY_CONF"
        ;;
    "everforest")
        sed -i 's|^include themes/.*\.conf|include themes/everforest.conf|' "$KITTY_CONF"
        ;;
    "nightowl")
        # Use catppuccin as fallback if nightowl doesn't exist for kitty
        sed -i 's|^include themes/.*\.conf|include themes/catppuccin-mocha.conf|' "$KITTY_CONF"
        ;;
esac

# Reload Kitty config for all instances
killall -SIGUSR1 kitty

# Update Waybar theme
pkill waybar
case $SELECTED_THEME in
    "catppuccin-mocha")
        ~/.config/waybar/launch.sh &
        ;;
    "everforest")
        ~/.config/waybar/launch.sh --everforest &
        ;;
    "nightowl")
        ~/.config/waybar/launch.sh --nightowl &
        ;;
esac

# Update Hyprland border colors (optional)
case $SELECTED_THEME in
    "catppuccin-mocha")
        hyprctl keyword general:col.active_border "rgb(b4befe)"
        hyprctl keyword general:col.inactive_border "rgb(45475a)"
        ;;
    "everforest")
        hyprctl keyword general:col.active_border "rgb(a7c080)"
        hyprctl keyword general:col.inactive_border "rgb(3d484d)"
        ;;
    "nightowl")
        hyprctl keyword general:col.active_border "rgb(82aaff)"
        hyprctl keyword general:col.inactive_border "rgb(011627)"
        ;;
esac

notify-send "Theme Switcher" "Switched to $SELECTED_THEME theme" -t 2000

#!/usr/bin/env bash

THEME_DIR="$HOME/.config"
THEMES=("catppuccin-mocha" "everforest" "nightowl")

# Use rofi to select theme
SELECTED_THEME=$(printf '%s\n' "${THEMES[@]}" | rofi -dmenu -i -p "Select Theme" -theme-str 'window {width: 400px;}')

if [ -z "$SELECTED_THEME" ]; then
    exit 0
fi

# Update Rofi theme
ROFI_CONF="$THEME_DIR/rofi/config.rasi"
ROFI_POWERMENU_CONF="$THEME_DIR/rofi/powermenu/config.rasi"
case $SELECTED_THEME in
    "catppuccin-mocha")
        sed -i 's|@import "colorschemes/.*\.rasi"|@import "colorschemes/catppuccin-mocha.rasi"|' "$ROFI_CONF"
        sed -i 's|@import "colorschemes/.*\.rasi"|@import "colorschemes/catppuccin-mocha.rasi"|' "$ROFI_POWERMENU_CONF"
        ;;
    "everforest")
        sed -i 's|@import "colorschemes/.*\.rasi"|@import "colorschemes/everforest.rasi"|' "$ROFI_CONF"
        sed -i 's|@import "colorschemes/.*\.rasi"|@import "colorschemes/everforest.rasi"|' "$ROFI_POWERMENU_CONF"
        ;;
    "nightowl")
        sed -i 's|@import "colorschemes/.*\.rasi"|@import "colorschemes/nightowl.rasi"|' "$ROFI_CONF"
        sed -i 's|@import "colorschemes/.*\.rasi"|@import "colorschemes/nightowl.rasi"|' "$ROFI_POWERMENU_CONF"
        ;;
esac

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
killall -SIGUSR1 kitty 2>/dev/null

# Update Swaync theme
SWAYNC_CONF="$THEME_DIR/swaync/config.json"
SWAYNC_CSS="$THEME_DIR/swaync/style.css"
case $SELECTED_THEME in
    "catppuccin-mocha")
        sed -i 's|@import "./colorschemes/.*\.css"|@import "./colorschemes/catppuccin-mocha.css"|' "$SWAYNC_CSS"
        ;;
    "everforest")
        sed -i 's|@import "./colorschemes/.*\.css"|@import "./colorschemes/everforest.css"|' "$SWAYNC_CSS"
        ;;
    "nightowl")
        sed -i 's|@import "./colorschemes/.*\.css"|@import "./colorschemes/nightowl.css"|' "$SWAYNC_CSS"
        ;;
esac

# Restart swaync
pkill swaync
swaync &

# Update Waybar theme
WAYBAR_STYLE="$THEME_DIR/waybar/style.css"
case $SELECTED_THEME in
    "catppuccin-mocha")
        sed -i 's|@import "colorschemes/.*\.css";|@import "colorschemes/catppuccin-mocha.css";|' "$WAYBAR_STYLE"
        ;;
    "everforest")
        sed -i 's|@import "colorschemes/.*\.css";|@import "colorschemes/everforest.css";|' "$WAYBAR_STYLE"
        ;;
    "nightowl")
        sed -i 's|@import "colorschemes/.*\.css";|@import "colorschemes/nightowl.css";|' "$WAYBAR_STYLE"
        ;;
esac

# Restart waybar
pkill waybar
waybar &

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

#!/usr/bin/env bash

STEAM_PATH="$HOME/.local/share/Steam/steamapps"
ICON_PATH="$HOME/.local/share/Steam/appcache/librarycache"
dir="$HOME/.config/rofi/gamelauncher"

# Parse installed games with icons
get_games() {
    for acf in "$STEAM_PATH"/appmanifest_*.acf; do
        if [[ -f "$acf" ]]; then
            name=$(grep -Po '"name"\s*"\K[^"]+' "$acf")
            appid=$(grep -Po '"appid"\s*"\K[^"]+' "$acf")
            # Skip Proton/Steam runtime entries
            [[ "$name" =~ ^(Proton|Steam\ Linux|Steamworks) ]] && continue

            # Find icon (try multiple formats)
            icon=""
            for ext in icon.jpg library_600x900.jpg header.jpg; do
                if [[ -f "$ICON_PATH/${appid}_${ext}" ]]; then
                    icon="$ICON_PATH/${appid}_${ext}"
                    break
                fi
            done

            echo "$name|$appid|$icon"
        fi
    done | sort
}

# Rofi menu with icons
selected=$(get_games | while IFS='|' read -r name appid icon; do
    if [[ -n "$icon" ]]; then
        echo -en "$name\x00icon\x1f$icon\n"
    else
        echo "$name"
    fi
done | rofi -dmenu -i -p "Games" -show-icons -theme "$dir/config.rasi")

[[ -z "$selected" ]] && exit 0

# Get appid for selected game
appid=$(get_games | grep "^$selected|" | cut -d'|' -f2)

# Launch game
steam steam://rungameid/"$appid"

#!/bin/bash

# Set environment for Hyprland
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY=$(ls "$XDG_RUNTIME_DIR"/wayland-* | head -1 | xargs basename)

CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
INDEX_FILE="$HOME/.config/hypr/wallpaper_index"

# Read wallpaper list from config
wallpapers=()
while IFS= read -r line; do
    if [[ "$line" =~ ^preload\ =\ (.*) ]]; then
        wallpapers+=("${BASH_REMATCH[1]}")
    fi
done < "$CONFIG_FILE"

# Check for wallpapers
if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "No wallpapers found!" >&2
    exit 1
fi

# Read current index
current_index=0
if [ -f "$INDEX_FILE" ]; then
    current_index=$(<"$INDEX_FILE")
fi

# Set current wallpaper
current_index=$((current_index % ${#wallpapers[@]}))
hyprctl hyprpaper wallpaper ",${wallpapers[current_index]}"

# Update index for next run
next_index=$(( (current_index + 1) % ${#wallpapers[@]} ))
echo "$next_index" > "$INDEX_FILE"

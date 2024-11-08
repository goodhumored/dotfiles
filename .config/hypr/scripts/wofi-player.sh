#!/bin/bash

# Function to get info for a player
get_player_info() {
    playerctl -p "$1" metadata --format "{{ artist }} - {{ title }}" 2>/dev/null
}

# Get the currently selected player from the file, if it exists
current_player=$(cat ~/.config/chosen_player 2>/dev/null)

# Get list of players
players=$(playerctl -l)

# Prepare the list for rofi by appending info about each player
menu=""
for player in $players; do
    info=$(get_player_info "$player")
    if [ -z "$info" ]; then
        info="(No track info)"
    fi
    # Highlight the current player with ✅
    if [ "$player" = "$current_player" ]; then
        menu+="✅ $player: $info\n"
    else
        menu+="$player: $info\n"
    fi
done

# Use rofi to choose the player
chosen=$(echo -e "$menu" | wofi -dmenu -p "Choose player" | awk -F: '{print $1}')

# If a player was chosen, save it to a file
if [ -n "$chosen" ]; then
    echo "$chosen" > ~/.config/chosen_player
    notify-send "Audio output switched" "Switched to $(echo "$chosen")"
fi


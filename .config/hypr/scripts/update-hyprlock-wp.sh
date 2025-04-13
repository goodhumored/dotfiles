#!/bin/bash

# Get the wallpaper information from hyprctl
hyprctl_output=$(hyprctl hyprpaper listactive)

echo "$hyprctl_output"

# Read the lines into an array and reverse their order
mapfile -t lines <<< "$hyprctl_output"
reversed_lines=()
for ((i=${#lines[@]}-1; i>=0; i--)); do
    reversed_lines+=("${lines[i]}")
done

# Generate the config content
config_content=""
for line in "${reversed_lines[@]}"; do
    # Split line into monitor and path parts
    IFS='=' read -r monitor_part path_part <<< "$line"
    
    # Trim whitespace from both parts
    monitor=$(echo "$monitor_part" | xargs)
    path=$(echo "$path_part" | xargs)
    
    # Skip entries with empty monitor names
    [[ -z "$monitor" ]] && continue
    
    # Append to the config content
    config_content+="background {
    monitor = $monitor
    path = $path
}
"
done

# Write to the configuration file
config_file="$HOME/.config/hypr/hyprlock-bg.conf"
echo "$config_content" > "$config_file"

echo "Generated hyprlock background config at: $config_file"

#!/bin/bash

# Get the current default sink
default_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')
default_sink_number=$(pactl list sinks short | grep "$default_sink" | awk '{print $1}')

# Get a list of available sinks with their descriptions
sinks=$(pactl list sinks | grep -E 'Sink|Description' | sed -E 's/Sink #([0-9]+)/\1/' | sed -E 's/Description: (.+)/\1/')

# Format the sink list to show the index and description
formatted_sinks=$(echo "$sinks" | awk 'NR%2{printf "%s ", $0; next;}1')

# Add ✅ to the current default sink
formatted_sinks=$(echo "$formatted_sinks" | awk -v default_sink_number="$default_sink_number" '{if ($1 == default_sink_number) {print "✅ " $0} else {print $0}}')

# Use wofi to select a sink based on the description
selected_sink=$(echo "$formatted_sinks" | wofi --dmenu --prompt "Select audio output:")

# Extract the sink index
sink_index=$(echo "$selected_sink" | awk '{print $1}')

# Set the selected sink as the default
if [ -n "$sink_index" ]; then
    pactl set-default-sink "$sink_index"
    notify-send "Audio output switched" "Switched to $(echo "$selected_sink" | cut -d' ' -f2-)"
else
    notify-send "No sink selected"
fi

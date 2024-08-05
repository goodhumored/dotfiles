#!/bin/bash

# Get the output of the pomodoro command
output=$(pomodoro -g)

# Extract the timer name and remaining time
timer_name=$(echo $output | awk '{print $1}')
remaining_time=$(echo $output | awk '{print $2}')

# Convert remaining time to seconds
remaining_seconds=$(( $(echo $remaining_time | awk -F: '{print $1 * 60 + $2}') ))

# Read the configuration file and get the total time for the current timer
config_file=~/.config/pomodoro/config
total_time=$(grep "^$timer_name" $config_file | awk '{print $2}')

# Convert total time to MM:SS format
total_minutes=$(( total_time / 60 ))
total_seconds=$(( total_time % 60 ))
total_time_formatted=$(printf "%02d:%02d" $total_minutes $total_seconds)

# Calculate the progress percentage
progress=$(( (total_time - remaining_seconds) * 100 / total_time ))

# Echo the timer name and progress
echo "{\"text\": \"$timer_name\", \"tooltip\": \"$timer_name ($remaining_time/$total_time_formatted)\", \"percentage\": $progress}"


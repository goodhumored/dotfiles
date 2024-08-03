title=$(playerctl metadata --format '{{markup_escape(artist)}} {{markup_escape(title)}}')
position=$(playerctl metadata --format '{{position}}')
length=$(playerctl metadata --format '{{mpris:length}}')

# Check if both position and length are not empty
if [[ -n "$position" && -n "$length" && -n "$title" ]]; then
  # Calculate the progress as a fraction
  progress=$(echo "scale=2; $position / $length" | bc)

  # Calculate the length of the title
  total_slots=$((${#title}/2))
  filled_slots=$(echo "$progress * $total_slots" | bc | awk '{printf("%d", $1 + 0.5)}')

  # Construct the progress bar string
  progress_string=""
  for ((i=1; i<=total_slots; i++)); do
    if [ $i -eq $filled_slots ]; then
      progress_string+="╡"
    elif [ $i -lt $filled_slots ]; then
      progress_string+="═"
    else
      progress_string+="─"
    fi
  done
fi

echo $(playerctl metadata --format "{\"text\": \"$title\r$progress_string\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}}")

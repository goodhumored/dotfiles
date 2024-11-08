title=$(playerctl --player=$(cat ~/.config/chosen_player) metadata --format '{{markup_escape(artist)}} - {{markup_escape(title)}}')
position=$(playerctl --player=$(cat ~/.config/chosen_player) metadata --format '{{position}}')
length=$(playerctl --player=$(cat ~/.config/chosen_player) metadata --format '{{mpris:length}}')
artUrl=$(playerctl --player=$(cat ~/.config/chosen_player) metadata --format "{{mpris:artUrl}}")

if [[ -n "$artUrl" ]]; then
  cover=$(echo "$artUrl" | sed "s/file:\/\///g")
else
  cover="$HOME/.config/waybar/custom/placeholder.jpg"
fi

if [[ "$cover" != $(cat ~/.config/waybar/custom/cover.cache) ]]; then
  echo "$cover" > ~/.config/waybar/custom/cover.cache
  cp $cover ~/.config/waybar/custom/cover.jpg
  killall waybar && waybar &
  exit
fi

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

if [[ -n "$progress_string" ]]; then
  title+="\r$progress_string"
fi

echo $(playerctl metadata --format "{\"text\": \"$title\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\", \"tooltip\": \"$title ({{ duration(position) }}/{{ duration(mpris:length) }})\"}")


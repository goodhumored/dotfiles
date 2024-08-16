result="$(brightnessctl set $1)"
current_perc="$(echo "$result" | grep -oP "\d{1,3}(?=%)")"
echo "$result"
echo "\"$current_perc\""
echo "$current_perc" >> /tmp/wobpipe

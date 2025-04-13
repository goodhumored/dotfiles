getFlagEmoji() {
  local countryCode=$1
  local flag=""
  
  # Convert country code to uppercase
  countryCode=$(echo "$countryCode" | tr '[:lower:]' '[:upper:]')
  
  # Iterate over each character in the country code
  for (( i=0; i<${#countryCode}; i++ )); do
    char="${countryCode:$i:1}"
    # Calculate the code point for the flag emoji
    codePoint=$((127397 + $(printf "%d" "'$char")))
    # Convert code point to the corresponding Unicode character
    flag+=$(printf "\\U$(printf '%08x' $codePoint)")
  done
  
  echo "$flag"
}
# TODO: get keyboard name dynamically
countryCode=$(hyprctl devices -j |
  jq -r '.keyboards[] | select(.main == true) | .active_keymap' |
  cut -c1-2 |
  tr 'a-z' 'A-Z')

if [ "$countryCode" = "EN" ]; then
  flagEmoji="🇺🇸"
else
  flagEmoji=$(getFlagEmoji "$countryCode")
fi
echo "$flagEmoji"

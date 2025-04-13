#!/bin/bash

# Path to the file storing the variables
SETTINGS_FILE="$HOME/.config/hypr/experimental_features.conf"

# Read the current values from the file
HDR=$(grep -oP 'hdr\s*=\s*\K(true|false)' "$SETTINGS_FILE")
WIDE_COLOR=$(grep -oP 'wide_color_gamut\s*=\s*\K(true|false)' "$SETTINGS_FILE")
XX_COLOR=$(grep -oP 'xx_color_management_v4\s*=\s*\K(true|false)' "$SETTINGS_FILE")

# Toggle the values
TOGGLE() {
  if [ "$1" == "true" ]; then
    echo "false"
  else
    echo "true"
  fi
}

NEW_HDR=$(TOGGLE "$HDR")
NEW_WIDE_COLOR=$(TOGGLE "$WIDE_COLOR")
NEW_XX_COLOR=$(TOGGLE "$XX_COLOR")

# Update the file with the new values
sed -i "s/hdr\s*=\s*$HDR/hdr = $NEW_HDR/" "$SETTINGS_FILE"
sed -i "s/wide_color_gamut\s*=\s*$WIDE_COLOR/wide_color_gamut = $NEW_WIDE_COLOR/" "$SETTINGS_FILE"
sed -i "s/xx_color_management_v4\s*=\s*$XX_COLOR/xx_color_management_v4 = $NEW_XX_COLOR/" "$SETTINGS_FILE"

# Optional: Notify the user of the new values
notify-send "Experimental Settings Toggled" "hdr = $NEW_HDR\nwide_color_gamut = $NEW_WIDE_COLOR\nxx_color_management_v4 = $NEW_XX_COLOR"

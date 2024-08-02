#!/bin/bash

# Get the current brightness level using brightnessctl
current_brightness=$(brightnessctl -m | grep -oP '\d+(?=%)')

# Check if current brightness is over 50%
if [ "$current_brightness" -gt 50 ]; then
    # Set brightness to 0%
    brightnessctl set 0%
    echo "Brightness set to 0%."
else
    # Set brightness to 100%
    brightnessctl set 100%
    echo "Brightness set to 100%."
fi

#!/usr/bin/env bash

mapfile -t messages< <(cat $CURRCOURSE/info.json | jq -r '.bookmarks | keys[]')
mapfile -t addresses< <(cat $CURRCOURSE/info.json | jq -r '.bookmarks[]')

# Rofi Logic
if [[ $# = 0 ]]; then
  for message in ${messages[@]}; do
    echo "$message"
  done
else
  for i in ${!messages[@]}; do
    if [[ $1 = "${messages[$i]}" ]]; then
      librewolf "${addresses[$i]}"
    fi
  done
fi

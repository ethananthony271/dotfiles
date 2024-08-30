#!/usr/bin/env bash

rofiConfig="-config ~/.config/rofi/abokMenu.rasi"
title=$(rofi $rofiConfig -markup-rows -dmenu -theme-str 'mainbox {children: [ "inputbar" ];} window {height: 44px; x-offset: 100px;} inputbar {spacing: 0px;} entry {placeholder: "bookmark title";}' -p "")

if [[ -z "$title" ]]; then
  notify-send "No Bookmark Created" "Title was not specified"
  exit 1
fi

url=$(rofi $rofiConfig -markup-rows -dmenu -theme-str 'mainbox {children: [ "inputbar" ];} window {height: 44px;} inputbar {spacing: 0px;} entry {placeholder: "bookmark url";}' -p "")
if [[ -z "$url" ]]; then
  notify-send "No Bookmark Created" "URL was not specified"
  exit 1
fi

category=$(jq --sort-keys -r "keys[]" $BOOKMARKS | rofi $rofiConfig -dmenu -p "bookmark category")
if [[ -z "$category" ]]; then
  notify-send "No Bookmark Created" "Category was not specified"
  exit 1
fi

jq --argjson url "\"$url\"" --arg title "$title" '.[$category][$title] = $url' --arg category "$category" $BOOKMARKS > "$(dirname $BOOKMARKS)"/temp_bookmarks.json
mv "$(dirname $BOOKMARKS)/temp_bookmarks.json" "$BOOKMARKS"
notify-send "Created New Bookmark" "$title in $category"

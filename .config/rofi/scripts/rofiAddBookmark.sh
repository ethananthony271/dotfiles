#!/usr/bin/env bash

rofiConfig="-config ~/.config/rofi/abokMenu.rasi"
# buffer=$(lz4jsoncat ~/.librewolf/q11askuj.default-default/sessionstore-backups/recovery.jsonlz4)
#
# declare -a messages
#
# numberOfWindows=$(echo $buffer | jq '.windows | length')
# for nWindow in $(seq 0 $(( $numberOfWindows - 1 ))); do
#
#   windowTabs=($(echo $buffer | jq --arg nWindow $nWindow ".windows[$nWindow] | .tabs[] | .entries | length"))
#
#   for nTab in $(seq 0 $(( ${#windowTabs[@]} - 1))); do
#     tabVersion=$(( ${windowTabs[$nTab]} - 1 ))
#     url=$(echo $buffer | jq --arg nWindow $nWindow -r --arg nTab $nTab --arg tabVersion $tabVersion ".windows[$nWindow] | .tabs[$nTab] | .entries[$tabVersion] | .url" | sed 's/&/\&amp;/g')
#     title=$(echo $buffer | jq --arg nWindow $nWindow -r --arg nTab $nTab --arg tabVersion $tabVersion ".windows[$nWindow] | .tabs[$nTab] | .entries[$tabVersion] | .title" | sed 's/&/\&amp;/g')
#     messages+=("$title <span weight='light' style='italic'>($url)</span>")
#   done
# done
#
# echoMessages () {
#   BIFS="$IFS"
#   IFS=$'\n'
#   for message in ${messages[@]}; do
#     echo -e "$message"
#   done
#   IFS="$BIFS"
# }

# title=$(echoMessages | rofi $rofiConfig -markup-rows -dmenu -p "bookmark title" | sed '/<span/ s/\(.*\)\s\s*<span.*>/\1/')
title=$(rofi $rofiConfig -markup-rows -dmenu -theme-str 'mainbox {children: [ "inputbar" ];} window {height: 44px; x-offset: 100px;} inputbar {spacing: 0px;} entry {placeholder: "bookmark title";}' -p "")

if [[ -z "$title" ]]; then
  notify-send "No Bookmark Created" "Title was not specified"
  exit 1
fi

# url=$(echoMessages | rofi $rofiConfig -dmenu -markup-rows -p "bookmark url" | sed '/<span/ s/.*<span.*>(\(.*\))<\/span>/\1/')
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

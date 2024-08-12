#!/usr/bin/env bash

BIFS="$IFS"
IFS=$'\n'



BOOKMARKS=$HOME/Documents/Personal/bookmarks.json

declare -a names
declare -a urls
for i in $(seq 0 $(($(jq -r "length" $BOOKMARKS)-1))); do
  mapfile -t tempNames < <(jq --sort-keys -r --arg i $i ".[keys[$i]] | keys[]" $BOOKMARKS)
  mapfile -t tempUrls < <(jq --sort-keys -r --arg i 1 ".[keys[$i]]" $BOOKMARKS | jq --sort-keys -r --arg i 1 ".[]")
  names+=("${tempNames[@]}")
  urls+=("${tempUrls[@]}")
done

declare -a messages
for i in ${!names[@]}; do
  messages+=("${names[$i]} <span weight='light' style='italic'>(${urls[$i]})</span>")
done

# Rofi Logic
if [[ $# = 0 ]]; then
  echo -en "\0markup-rows\x1ftrue\n"
  for i in ${!names[@]}; do
    # echo -e "${names[$i]} <i>(${urls[$i]})</i>"
    echo -e "${messages[$i]}"
  done
else
  coproc ( bash -c "librewolf $(echo $1 | sed -E 's/.*\(([^)]*)\).*/\1/')"  > /dev/null  2>&1 )
  exit 0
fi

IFS="$BIFS"

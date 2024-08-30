#!/usr/bin/env bash

BIFS="$IFS"
IFS=$'\n'

getFolders () {
  for i in $(seq 0 $(($(jq -r "length" $BOOKMARKS)-1))); do
    echo "$(jq -r "keys[$i]" $BOOKMARKS)"
  done
}

mapfile -t folders < <(getFolders)

isFolder () {
  for i in ${!folders[@]}; do
    if [[ $1 = "${folders[$i]}" ]]; then
      echo $i
      exit 0
    fi
  done
  echo -1
  exit 0
}

# Rofi Logic
if [[ $# = 0 || "$1" = "<i>..</i>" ]]; then
  for folder in ${folders[@]}; do
    echo "$folder"
  done
elif [[ i=$(isFolder $1) -ge 0 ]]; then
	echo -en "\0markup-rows\x1ftrue\n"
	echo -en "\x00prompt\x1f${folders[$i]}\n"
  mapfile -t names < <(jq --sort-keys -r --arg i $i ".[keys[$i]] | keys[]" $BOOKMARKS)
  mapfile -t urls < <(jq --sort-keys -r --arg i 1 ".[keys[$i]]" $BOOKMARKS | jq --sort-keys -r --arg i 1 ".[]")
  echo -e "<i>..</i>"
  for i in ${!names[@]}; do
    echo -e "${names[$i]} <span weight='light' style='italic'>(${urls[$i]})</span>"
  done
else
  coproc ( bash -c "xdg-open $(echo $1 | sed -E 's/.*\(([^)]*)\).*/\1/')"  > /dev/null  2>&1 )
fi

IFS="$BIFS"

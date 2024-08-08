#!/usr/bin/env bash

getTemplateName () {
  line=$(cat $1 | rg \title)
  title=$(echo $line | sed 's/\\title{\(.*\)}/\1/')
  echo $title
}

templateDirectory=$HOME/Documents/School/quarter04/xlatex/templates

mapfile -t types < <(find $templateDirectory -mindepth 1 -maxdepth 1 -type d)

options=()
declare -A messages
declare -A commands
for i in ${!types[@]}; do
  mapfile -t temp < <(find "${types[$i]}" -mindepth 1 -maxdepth 1 -type f)
  for j in ${!temp[@]}; do
    type="$(basename $(dirname "${temp[$j]}"))"
    type="${type^}"
    title=$(getTemplateName "${temp[$j]}")
    messages[$i$j]="$type: $title"
    if [[ "$type" = "Figure" ]]; then
      commands[$i$j]="createLatexFromTemplate -f '${temp[$j]}'"
    elif [[ "$type" = "Lecture" ]]; then
      commands[$i$j]="createLatexFromTemplate -l '${temp[$j]}'"
    else
      commands[$i$j]="notify-send 'New File Not Created'"
    fi
    options+=($i$j)
  done
done

# Rofi Logic
if [[ $# = 0 ]]; then
  for option in ${options[@]}; do
    echo "${messages[$option]}"
  done
else
  for option in ${options[@]}; do
    if [[ $1 = "${messages[$option]}" ]]; then
      bash -c "${commands[$option]}"
    fi
  done
fi

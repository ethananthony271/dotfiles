#!/usr/bin/env bash

TEMPLATES=$CURRQUARTER/xlatex/templates

mapfile -t paths < <(find $TEMPLATES -mindepth 2 -maxdepth 2 -type f)
declare -a messages
declare -a commands
for i in ${!paths[@]}; do
  type=$(basename $(dirname "${paths[$i]}") | sed 's/\(...\).*/\1/')
  name="$(echo $(cat "${paths[$i]}" | rg \title) | sed 's/\\title{\(.*\)}/\1/')"
  messages+=("$type: $name <span weight='light' style='italic'>($(basename ${paths[$i]}))</span>")
  if [[ $type = "fig" ]]; then
    commands+=("cp '${paths[$i]}' '$(courseInfo -F)' && notify-send 'Figure Created in $(courseInfo -s)' '$name as $(basename $(courseInfo -f))'")
  elif [[ $type = "lec" ]]; then
    commands+=("cp '${paths[$i]}' '$(courseInfo -L)' && notify-send 'Lecture Created in $(courseInfo -s)' '$name as $(basename $(courseInfo -l))'")
  else
    notify-send "Unsupported Template Type: $type" "${paths[$i]}"
    exit 1
  fi
done

# # Rofi Logic
if [[ $# = 0 ]]; then
  for i in ${!messages[@]}; do
    echo -en "\0markup-rows\x1ftrue\n"
    echo -en "${messages[$i]}"
  done
else
  for i in ${!messages[@]}; do
    if [[ $1 = "${messages[$i]}" ]]; then
      bash -c "${commands[$i]}"
    fi
  done
fi

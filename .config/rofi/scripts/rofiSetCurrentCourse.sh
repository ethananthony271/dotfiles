#!/usr/bin/env bash

# Options
options=() # refresh

p=$(find $CURRQUARTER -mindepth 1 -maxdepth 1 -type d)
paths=()
for path in $p; do
  if [[ ! $path =~ "xlatex" ]]; then
    if [[ $path =~ ^/home/ea/(.*)$ ]]; then
      paths+=("${BASH_REMATCH[1]}");
    fi
  fi
done

courses=()
for path in ${paths[@]}; do
  courseShort=$(cat "$path/info.json" | jq -r .short)
  courseTitle=$(cat "$path/info.json" | jq -r .title)
  courses+=("$courseShort - $courseTitle")
done

declare -A messages
messages[refresh]="Refresh Current Course"
for i in ${!courses[@]}; do
  messages[class$i]="${courses[$i]}"
  options+=(class$i)
done

declare -A commands
commands[refresh]="setCurrentCourse -a"
for i in ${!paths[@]}; do
  commands[class$i]="setCurrentCourse -s ${paths[$i]}"
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

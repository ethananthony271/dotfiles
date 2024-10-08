#!/usr/bin/env bash

# Options
all=(get refresh)

options=()

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
  courseShort=$(courseInfo "$path" --short)
  courseTitle=$(courseInfo "$path" --title)
  courses+=("$courseShort - $courseTitle")
done

declare -A messages
messages[refresh]="Refresh Current Course"
messages[get]="Get Current Course"
for i in ${!courses[@]}; do
  messages[class$i]="${courses[$i]}"
  options+=(class$i)
done

declare -A commands
commands[refresh]="courseTools --auto-course"
commands[get]="notify-send 'Current Course Information' '$(courseInfo --short) - $(courseInfo --title)'"
for i in ${!paths[@]}; do
  commands[class$i]="courseTools --set-course ${paths[$i]}"
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

#!/usr/bin/env bash

quarterDirectory="$HOME/Documents/School/quarter04"

# Functions
getNewCourseNumber() {
  time=$(date +"%H%M")
  time=$(echo $time | sed 's/^0*//')
  day=$(date +"%a")

  for i in $(seq 1 $numberOfClasses); do
    startTime=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $1}')
    endTime=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $2}')
    days=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $3}')

    if [[ $startTime -le $time && $endTime -gt $time && $days =~ $day ]]; then
      echo $i
      return 0
    fi
  done
  echo -1
  return 0
}

setCurrentCourse() {
  symLinkTarget=$1
  symLinkDirectory=$currentCourseDirectory
  ln -sfn "$symLinkTarget" "$symLinkDirectory"
  return 0
}

getCurrentCourse () {
  temp=$(readlink -f $currentCourseDirectory)
  directory=$(basename $temp)
  currentCode=$(echo $directory | awk --field-separator=_ '{print $1}')
  currentNumber=$(echo $directory | awk --field-separator=_ '{print $2}')

  for i in $(seq 1 $numberOfClasses); do
    code=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $5}')
    number=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $6}')
    if [[ $currentCode -eq $code && $currentNumber -eq $number ]]; then
      title=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $7}')
      echo "$code $number - $title"
      return 0
    fi
  done
}

# Options
p=$(find $quarterDirectory -maxdepth 1 -type d)
paths=()
for path in $p; do
  if [[ $path != $quarterDirectory && ! $path =~ "xlatex" ]]; then
    paths+=($path);
  fi
done

courses=()
for path in ${paths[@]}; do
  courseShort=$(cat "$path/info.json" | jq -r .short)
  courseTitle=$(cat "$path/info.json" | jq -r .title)
  courses+=("$courseShort - $courseTitle")
done

options=(refresh)

declare -A messages
messages[refresh]="Refresh Current Course"
for i in ${!courses[@]}; do
  messages[class$i]="${courses[$i]}"
  options+=(class$i)
done

declare -A commands
commands[refresh]="changeCurrentCourse.sh"
for i in ${!paths[@]}; do
  commands[class$i]="changeCurrentCourse.sh ${paths[$i]}"
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

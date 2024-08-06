#!/usr/bin/env bash

quarterDirectory=$HOME/Documents/School/quarter04
currentCourseDirectory=$HOME/Documents/School/currentCourse

getNewCourseDirectory() {
  time=$(date +"%H%M")
  time=$(echo $time | sed 's/^0*//')
  day=$(date +"%a")

  paths=$(find $quarterDirectory -maxdepth 1 -type d)
  coursePaths=()
  for path in $paths; do
    if [[ $path != $quarterDirectory && ! $path =~ "xlatex" ]]; then
      coursePaths+=($path);
    fi
  done

  for path in ${coursePaths[@]}; do
    start=$(cat "$path/info.json" | jq -r .start)
    end=$(cat "$path/info.json" | jq -r .end)
    days="$(cat "$path/info.json" | jq -r .days)"

    if [[ $start -le $time && $end -gt $time && $days =~ $day ]]; then
      echo $path
      return 0
    fi

    if [[ "$(cat "$path/info.json" | jq -r .hasLab)" = true ]]; then
      labStart=$(cat "$path/info.json" | jq -r .labStart)
      labEnd=$(cat "$path/info.json" | jq -r .labEnd)
      labDays="$(cat "$path/info.json" | jq -r .labDays)"

      if [[ $labStart -le $time && $labEnd -gt $time && $labDays =~ $day ]]; then
        echo $path
        return 0
      fi
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
  directory=$(readlink -f $currentCourseDirectory)
  code=$(cat "$directory/info.json" | jq -r .code)
  number=$(cat "$directory/info.json" | jq -r .number)
  title="$(cat "$directory/info.json" | jq -r .title)"
  echo "$code $number - $title"
  return 0
}

if [[ $# = 0 ]]; then
  newCourseDirectory=$(getNewCourseDirectory)
  if [[ -d "$newCourseDirectory" ]]; then
    setCurrentCourse $newCourseDirectory
    notify-send "Current Course Changed" "$(getCurrentCourse)"
  else
    notify-send "Current Course Unchanged" "$(getCurrentCourse)"
  fi
else
  if [ -d  $1 ]; then # TODO: better path verification
    setCurrentCourse $1
    notify-send "Current Course Changed" "$(getCurrentCourse)"
  else
    notify-send "Current Course Unchanged" "$(getCurrentCourse)"
  fi
fi

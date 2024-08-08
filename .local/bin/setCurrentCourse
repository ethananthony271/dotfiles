#!/usr/bin/env bash

silent=false

getNewCourseDirectory () {
  time=$(date +"%H%M")
  time=$(echo $time | sed 's/^0*//')
  day=$(date +"%a")

  paths=$(find $CURRCOURSE -mindepth 1 -maxdepth 1 -type d)
  coursePaths=()
  for path in $paths; do
    if [[ ! $path =~ "xlatex" ]]; then
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

setCurrentCourse () {
  symLinkTarget="$1"
  symLinkDirectory=$CURRCOURSE
  ln -sfn "$symLinkTarget" "$symLinkDirectory"
}

echoHelpMessage () {
  echo "setCurrentCourse - a tool to manage the current course"
  echo
  echo "Change the current course value from the command line and notify the user of"
  echo "what the current course is. Uses freedesktop.org notification standards"
  echo
  echo "Usage: setCurrentCourse [-q] [-g] [-a] [-s DIRECTORY]"
  echo "  Currently, no options are mutually exclusive. However, using both -a and -s"
  echo "  in the same run is redundant and discouraged."
  echo
  echo "Available Options:"
  echo "  -q                  Prevents sending system notifications from this program"
  echo "  -g                  Send a notification containing the information of the"
  echo "                      current course."
  echo "  -a                  Read course information from info.json files in course"
  echo "                      directories and automatically update current course if"
  echo "                      applicable"
  echo "  -s DIRECTORY        Sets the current course to DIRECTORY. DIRECTORY must be"
  echo "                      a child of \$CURRCOURSE environment variable."
}

while getopts 'qgas:h' opt; do
  case "$opt" in
    q)
      silent=true
      ;;

    g)
      title=$(getCurrentCourseInfo -t)
      short=$(getCurrentCourseInfo -s)
      if [[ "$silent" = "false" ]]; then
        notify-send "Get Current Course" "$short - $title"
      fi
      ;;

    a)
      newCourseDirectory=$(getNewCourseDirectory)
      if [ -d "$newCourseDirectory" ]; then
        setCurrentCourse "$newCourseDirectory"
        title=$(getCurrentCourseInfo -t)
        short=$(getCurrentCourseInfo -s)
        if [[ "$silent" = "false" ]]; then
          notify-send "Current Course Changed" "$short - $title"
        fi
      else
        title=$(getCurrentCourseInfo -t)
        short=$(getCurrentCourseInfo -s)
        if [[ "$silent" = "false" ]]; then
          notify-send "Current Course Unchanged" "$short - $title"
        fi
      fi
      ;;

    s)
      newCourseDirectory="$(pwd)/$OPTARG"
      result=$(find "$CURRQUARTER" -type d -wholename "$newCourseDirectory")
      if [[ -n $result ]]; then
        setCurrentCourse "$newCourseDirectory"
        title=$(getCurrentCourseInfo -t)
        short=$(getCurrentCourseInfo -s)
        if [[ "$silent" = "false" ]]; then
          notify-send "Current Course Changed" "$short - $title"
        fi
      else
        title=$(getCurrentCourseInfo -t)
        short=$(getCurrentCourseInfo -s)
        if [[ "$silent" = "false" ]]; then
          notify-send "Current Course Unchanged" "$short - $title"
        fi
      fi
      ;;

    h)
      echoHelpMessage
      ;;

    esac
  done

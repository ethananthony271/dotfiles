#!/usr/bin/env bash

while getopts 'l:f:' opt; do
  case "$opt" in
    l)
      workingDirectory=$HOME/Documents/School/currentCourse/notes
      fileBase="lec_"
      template="$OPTARG"
      templateType="Lecture"
      ;;

    f)
      workingDirectory=$HOME/Documents/School/currentCourse/notes/figures
      fileBase="fig_"
      template="$OPTARG"
      templateType="Figure"
      ;;

    ?|h)
      echo "Usage: $(basename $0) [-l arg] [-f arg]"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

mapfile -t files < <(find $workingDirectory -mindepth 1 -maxdepth 1 -type f)

for i in ${!files[@]}; do
  filename=$(basename "${files[$i]}")
  if [[ ! "$filename" =~ ^$fileBase(0*)([0-9]*)(_[0-9])?\.tex$ ]]; then
    files=( "${files[@]:0:$i}" "${files[@]:(($i + 1))}" )
  fi
done

if [[ ${#files[@]} -gt 0 ]]; then
  lastFile=$(basename ${files[${#files[@]} - 1]})
  if [[ "$lastFile" =~ ^$fileBase(0*)([0-9]*)(_[0-9])?\.tex$ ]]; then
    number="${BASH_REMATCH[2]}"
    ((number++))
    number=$(printf "%03d" $number)

    newFilePath="$workingDirectory/$fileBase$number.tex"
  else
    echo "No match"
  fi
else
  number=001
  newFilePath="$workingDirectory/$fileBase$number.tex"
fi

cp "$template" "$newFilePath"

line=$(cat $template | rg \title)
title=$(echo $line | sed 's/\\title{\(.*\)}/\1/')

notify-send "Created New $templateType" "$title
$(basename $newFilePath) in $(getCurrentCourseInfo.sh -s) - $(getCurrentCourseInfo.sh -t)
"

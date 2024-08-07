#!/usr/bin/env bash

currentCourseInfo=$HOME/Documents/School/currentCourse/info.json

while getopts 'tscn' opt; do
  case "$opt" in
    t)
      echo $(cat "$currentCourseInfo" | jq -r .title)
      ;;

    s)
      echo $(cat "$currentCourseInfo" | jq -r .short)
      ;;

    c)
      echo $(cat "$currentCourseInfo" | jq -r .code)
      ;;

    n)
      echo $(cat "$currentCourseInfo" | jq -r .number)
      ;;

    ?|h)
      echo "Usage: $(basename $0) WRONG"
      exit 1
      ;;
  esac
done

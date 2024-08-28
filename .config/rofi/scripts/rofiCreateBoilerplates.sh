#!/usr/bin/env bash

TEMPLATES=$CURRQUARTER/xlatex/templates

mapfile -t paths < <(find $TEMPLATES -mindepth 2 -maxdepth 2 -type f)

declare -a messages
declare -a commands

for i in ${!paths[@]}; do
  templatePath="${paths[$i]}"
  type=$(basename $(dirname "$templatePath") | sed 's/\(...\).*/\1/')
  title="$(echo $(cat "$templatePath" | rg '\\title') | sed 's/\\title{\(.*\)}/\1/')"
  messages+=("$type: $title <span weight='light' style='italic'>($(basename $templatePath))</span>")

  if [[ $type = "fig" ]]; then
    newPath="$(courseInfo --next-figure)"
    newName="$(echo $newPath | sed 's/^.*\/\(.*\)\.tex/\1/')"
    commands+=("courseTools --create-figure '$templatePath' && echo -n '\includestandalone{figures/$newName}' | wl-copy")
  elif [[ $type = "lec" ]]; then
    newPath="$(courseInfo --next-lecture)"
    newName="$(echo $newPath | sed 's/^.*\/\(.*\)\.tex/\1/')"
    commands+=("courseTools --create-lecture '$templatePath' && echo -n '\includestandalone{figures/$newName}' | wl-copy")
  else
    notify-send "Unsupported Template Type: $type" "$templatePath"
    exit 1
  fi
done

# Rofi Logic
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

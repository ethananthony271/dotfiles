#!/usr/bin/env bash

mapfile -t messages< <(jq -r '.bookmarks | keys[]' $(courseInfo --path)/info.json)
mapfile -t commands< <(jq -r '.bookmarks[]' $(courseInfo --path)/info.json | sed "s/^\(.*\)$/xdg-open '\1'/")

messages+=("Open in Terminal")
commands+=("foot -D $(courseInfo --path)")

messages+=("Open in File Browser")
commands+=("xdg-open '$(courseInfo --path)'")

messages+=("View Course Notes (Full Compile)")
commands+=("courseTools --update-main-full && cd $(courseInfo --path)/notes && pdflatex --shell-escape ./main.tex && pdflatex --shell-escape ./main.tex && courseTools -c && xdg-open ./main.pdf")

messages+=("View Course Notes (Don't Compile)")
commands+=("xdg-open $(courseInfo --path)/notes/main.pdf")

messages+=("Clean Directory")
commands+=("courseTools -C")

# Rofi Logic
if [[ $# = 0 ]]; then
  for i in ${!messages[@]}; do
    echo "${messages[$i]}"
  done
else
  for i in ${!messages[@]}; do
    if [[ $1 = "${messages[$i]}" ]]; then
      coproc ( bash -c "${commands[$i]}"  > /dev/null  2>&1 )
    fi
  done
fi

#!/usr/bin/env bash

mapfile -t messages< <(cat $CURRCOURSE/info.json | jq -r '.bookmarks | keys[]')
mapfile -t addresses< <(cat $CURRCOURSE/info.json | jq -r '.bookmarks[]')

commands=()
for address in ${addresses[@]}; do
  commands+=("librewolf $address")
done

messages+=("Open in Terminal")
commands+=("foot -D $(courseInfo --path)")

messages+=("Open in File Browser")
commands+=("foot -e yazi $(courseInfo --path)")

messages+=("Edit Last Lecture")
commands+=("foot -e nvim $(courseInfo --last-lecture)")

messages+=("View Course Notes (Compile)")
commands+=("cd $(courseInfo --path)/notes && pdflatex ./master.tex && courseTools -c && zathura ./master.pdf")

messages+=("View Course Notes (Don't Compile)")
commands+=("zathura $(courseInfo --path)/notes/master.pdf")

messages+=("Clean Directory")
commands+=("cleanDirectory")

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

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

messages+=("View Course Notes (Full Compile)")
commands+=("courseTools --update-main-full && cd $(courseInfo --path)/notes && pdflatex --shell-escape ./main.tex && pdflatex --shell-escape ./main.tex && courseTools -c && zathura ./main.pdf")

messages+=("View Course Notes (Recent Compile)")
commands+=("courseTools --update-main-new 3 && cd $(courseInfo --path)/notes && pdflatex --shell-escape ./main.tex && pdflatex --shell-escape ./main.tex && courseTools -c && zathura ./main.pdf")

messages+=("View Course Notes (Don't Compile)")
commands+=("zathura $(courseInfo --path)/notes/main.pdf")

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

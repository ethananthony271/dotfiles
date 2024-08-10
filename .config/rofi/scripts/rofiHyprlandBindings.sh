#!/bin/bash


mapfile -t descriptions < <(hyprctl binds | rg --trim --replace="" description: )
mapfile -t keys < <(hyprctl binds | rg --trim --replace="" key: )
mapfile -t dispatchers < <(hyprctl binds | rg --trim --replace="" dispatcher: )
mapfile -t args < <(hyprctl binds | rg --trim --replace="" arg: )

mapfile -t modmasks < <(hyprctl binds | rg --trim --replace="" modmask: )
for i in "${!modmasks[@]}"; do
  if [[ "${modmasks[$i]}" = 0 ]]; then
    modmasks[$i]=""
  elif [[ "${modmasks[$i]}" = 64 ]]; then
    modmasks[$i]="\$mod + "
  elif [[ "${modmasks[$i]}" = 65 ]]; then
    modmasks[$i]="\$mod Shift + "
  elif [[ "${modmasks[$i]}" = 68 ]]; then
    modmasks[$i]="\$mod Ctrl + "
  elif [[ "${modmasks[$i]}" = 69 ]]; then
    modmasks[$i]="\$mod Shift Ctrl + "
  else
    modmasks[$i]="Modmask + "
  fi
done

# Rofi Logic
if [[ $# = 0 ]]; then
  for i in ${!descriptions[@]}; do
    if [[ -n ${descriptions[$i]} ]]; then
      echo "${modmasks[$i]}${keys[$i]}: ${descriptions[$i]}"
    fi
  done
else
  for i in ${!descriptions[@]}; do
    if [[ $1 = "${modmasks[$i]}${keys[$i]}: ${descriptions[$i]}" ]]; then
      dispatcher=${dispatchers[$i]}
      arg=${args[$i]}
      hyprctl -q dispatch "$dispatcher" "$arg"
    fi
  done
fi

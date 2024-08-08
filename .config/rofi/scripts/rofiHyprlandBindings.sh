#!/bin/bash

command="hyprctl binds"

pattern="description"
mapfile -t descriptions < <(hyprctl binds | grep ${pattern})
for i in "${!descriptions[@]}"; do
  temp=$(echo "${descriptions[$i]}" | sed -n "s/^.*${pattern}:\s*\(.*\)$/\1/p")
  descriptions[$i]=$(echo $temp)
done

pattern="modmask"
mapfile -t modmasks < <(hyprctl binds | grep ${pattern})
for i in "${!modmasks[@]}"; do
  if [[ "${modmasks[$i]}" =~ 0 ]]; then
    modmasks[$i]=""
  elif [[ "${modmasks[$i]}" =~ 64 ]]; then
    modmasks[$i]="\$mod + "
  elif [[ "${modmasks[$i]}" =~ 65 ]]; then
    modmasks[$i]="\$mod Shift + "
  elif [[ "${modmasks[$i]}" =~ 68 ]]; then
    modmasks[$i]="\$mod Ctrl + "
  elif [[ "${modmasks[$i]}" =~ 69 ]]; then
    modmasks[$i]="\$mod Shift Ctrl + "
  else
    modmasks[$i]="Modmask + "
  fi
done

pattern="key:"
mapfile -t keys < <(hyprctl binds | grep ${pattern})
for i in "${!keys[@]}"; do
  temp=$(echo "${keys[$i]}" | sed -n "s/^.*${keys}:\s*\(.*\)$/\1/p")
  keys[$i]=$(echo $temp)
done

pattern="dispatcher"
mapfile -t dispatchers < <(hyprctl binds | grep ${pattern})

pattern="arg"
mapfile -t args < <(hyprctl binds | grep ${pattern})

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
      dispatcher=$(echo "${dispatchers[$i]}" | sed -n "s/^.*dispatcher:\s*\(.*\)$/\1/p")
      arg=$(echo "${args[$i]}" | sed -n "s/^.*arg:\s*\(.*\)$/\1/p")
      hyprctl -q dispatch "$dispatcher" "$arg"
    fi
  done
fi

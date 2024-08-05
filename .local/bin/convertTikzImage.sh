#!/usr/bin/env bash

# Set all variables
workingDirectory="$HOME/Documents/School/currentCourse/notes/figures"
temp=$(ls $workingDirectory/*.tex | sed 's|.*/||' | rofi -dmenu -p "source file" -config ~/.config/rofi/mainMenu.rasi)
filename=$( echo $temp | sed 's/\.[^.]*$//' )
texFilePath=${workingDirectory}"/"${filename}".tex"
pdfFilePath=${workingDirectory}"/"${filename}".pdf"
pngFilePath=${workingDirectory}"/"${filename}".png"

# Create a .pdf and .png file from the .tex file
pdflatex --output-directory=$workingDirectory $texFilePath
magick -density 600x600 $pdfFilePath -quality 90 -resize 800x600 ${workingDirectory}"/"${filename}".png"

# Copy the path to the PNG to the system clipboard
echo ${pngFilePath} | wl-copy

# Remove all non .pdf .png and .tex files
regex='(.*\.(pdf|tex|png)$)'
mapfile -t files < <(find "$workingDirectory" -maxdepth 1 -type f)
for file in ${files[@]}; do
  if [[ !($file =~ $regex) ]]; then
    rm $file
  fi
done

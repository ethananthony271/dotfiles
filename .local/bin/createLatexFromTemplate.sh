#!/usr/bin/env bash

echoHelpMessage () {
  echo "createLatexFromTemplate - create new files in the current course directory"
  echo "                          based on templates stored in the appropriate xlatex"
  echo "                          directory."
  echo
  echo "Use templates stored in \$CURRQUARTER/xlatex/templates/ to create new files in"
  echo "their approriate location within the current course directory and sequentially"
  echo "name them according to which files already exist."
  echo
  echo "Available Options:"
  echo "-l [FILE PATH]        Creates a new lecture file in currentCourse/notes/ named"
  echo "                      lec_XXX.tex, where XXX is the next lowest number currently"
  echo "                      unused."
  echo "-f [FILE PATH]        Creates a new figure file in currentCourse/notes/figures/"
  echo "                      named fig_XXX.tex, where XXX is the next lowest number"
  echo "                      currently unused."
}

createFile () {
  templatePath="$1"
  templateType="$2"
  if [[ "$templateType" = "Figure" ]]; then
    fileBase=fig_
    workingDirectory=$CURRCOURSE/notes/figures
  elif [[ "$templateType" = "Lecture" ]]; then
    fileBase=lec_
    workingDirectory=$CURRCOURSE/notes
  fi

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

  cp "$templatePath" "$newFilePath"

  if [[ -n $(find "$workingDirectory" "$newFilePath") ]]; then
    line=$(cat $templatePath | rg \title)
    title=$(echo $line | sed 's/\\title{\(.*\)}/\1/')

    notify-send "Created New $templateType" "$title
$(basename $newFilePath) in $(getCurrentCourseInfo -s) - $(getCurrentCourseInfo -t)
"
  else
    notify-send "Did Not Create New $templateType" "$newFilePath"
  fi
}

while getopts 'l:f:h' opt; do
  case "$opt" in
    l)
      tp="$OPTARG"
      tt="Lecture"
      createFile "$tp" "$tt"
      ;;

    f)
      tp="$OPTARG"
      tt="Figure"
      createFile "$tp" "$tt"
      ;;

    h)
      echoHelpMessage
      ;;

    ?)
      echo "Usage: $(basename $0) [-l arg] [-f arg]"
      echo
      echoHelpMessage
      exit 1
      ;;
  esac
done

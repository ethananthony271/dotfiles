#!/usr/bin/env bash

# COMP 2300 - Discrete Structures in Computer Science: 14:00-15:50 T/R
# ENME 2510 - Statics: 12:00-12:50 M/W/R/F
# ENME 2510 - Statics: 16:00-17:50 T
# PHYS 1213 - University Physics III: 11:00-11:50 M/W/R/F
# PHIL 2145 - Between Deluze and Foucault: 14:00-15:50 M/W
# ENCE 2101 - Digital Design: 09:00-09:50 M/W
# ENCE 2101 - Digital Design: 12:00-13:50 T

# Class Format: Start Time-End Time-Days of Week-Directory Name-Letter Code-Course Number-Course Title

classes="1400-1600-Tue Thu-COMP_2300-COMP-2300-Discrete Structures in Computer Science
1200-1300-Mon Wed Thu Fri-ENME_2510-ENME-2510-Statics
1600-1800-Tue-ENME_2510-ENME-2510-Statics
1100-1200-Mon Wed Fri-PHYS_1213-PHYS-1213-University Physics III
1400-1600-Mon Wed-PHIL_2145-PHIL-2145-Between Deluze and Foucault
900-1000-Mon Wed-ENCE_2101-ENCE-2101-Digital Design
1200-1400-Thu-ENCE_2101-ENCE-2101-Digital Design"

numberOfClasses=$(echo "$classes" | wc -l)

currentCourseDirectory=$HOME/Documents/School/currentCourse

getNewCourseNumber() {
  time=$(date +"%H%M")
  time=$(echo $time | sed 's/^0*//')
  day=$(date +"%a")

  for i in $(seq 1 $numberOfClasses); do
    startTime=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $1}')
    endTime=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $2}')
    days=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $3}')

    if [[ $startTime -le $time && $endTime -gt $time && $days =~ $day ]]; then
      echo $i
      return 0
    fi
  done
  echo -1
  return 0
}

setCurrentCourse() {
  symLinkTarget=$1
  symLinkDirectory=$currentCourseDirectory
  ln -sfn "$symLinkTarget" "$symLinkDirectory"
  return 0
}

getCurrentCourse () {
  temp=$(readlink -f $currentCourseDirectory)
  directory=$(basename $temp)
  currentCode=$(echo $directory | awk --field-separator=_ '{print $1}')
  currentNumber=$(echo $directory | awk --field-separator=_ '{print $2}')

  for i in $(seq 1 $numberOfClasses); do
    code=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $5}')
    number=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $6}')
    if [[ $currentCode -eq $code && $currentNumber -eq $number ]]; then
      title=$(echo "$classes" | awk --field-separator=- -v row="$i" 'NR == row {print $7}')
      echo "$code $number - $title"
      return 0
    fi
  done
}

if [[ $# = 0 ]]; then
  currentCourseNumber=$(getNewCourseNumber)
  if [[ $currentCourseNumber -ge 0 ]]; then
    newCoursePath="$HOME/Documents/School/quarter04/$(echo "$classes" | awk --field-separator=- -v row="$currentCourseNumber" 'NR == row {print $4}')"
    setCurrentCourse $newCoursePath
    echo $newCoursePath
    notify-send "Current Course Changed" "$(getCurrentCourse)"
  else
    notify-send "Current Course Unchanged" "$(getCurrentCourse)"
  fi
else
  if [ -d  $1 ]; then # TODO: better path verification
    setCurrentCourse $1
    notify-send "Current Course Changed" "$(getCurrentCourse)"
  else
    notify-send "Current Course Unchanged" "$(getCurrentCourse)"
  fi
fi

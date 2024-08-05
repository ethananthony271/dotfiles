lsReturnValue=$(ls ~/Documents/School/currentCourse/notes/figures)
figures=()
filePath="/home/ea/Documents/School/currentCourse/notes/figures/"

mapfile -t files < <(find "$workingDirectory" -maxdepth 1 -type f)

for i in $lsReturnValue; do figures+=($i) ; done

filePath+="fig_"
number=$(( ${#figures[@]} + 1 ))
number=$(printf "%03d" $number)
filePath+=$number
filePath+=".tex"

touch $filePath

cat << EOL > $filePath
\documentclass{standalone}

\title{Figure $number}

\begin{document}
  \begin{tikzpicture}

  \end{tikzpicture}
\end{document}
EOL

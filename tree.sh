#!usr/bin/bash

export LANG=en_US.UTF-8

shopt -s nullglob
dir_count=0
file_count=0

traverse() {
  dir_count=$(($dir_count + 1))
  local directory=$1
  local prefix=$2

  local children=("$directory"/*)
  local child_count=${#children[@]}

  for idx in "${!children[@]}"; do 
    local child=${children[$idx]}

    local child_prefix="\u2502\u00A0\u00A0\u0020"
    local pointer="\u251c\u2500\u2500\u0020"

    if [ $idx -eq $((child_count - 1)) ]; then
      pointer="\u2514\u2500\u2500\u0020"
      child_prefix="    "
    fi

    printf "$prefix$pointer${child##*/}\n"
    [ -d "$child" ] &&
      traverse "$child" "$prefix$child_prefix" ||
      file_count=$((file_count + 1))
  done
}

root="."
[ "$#" -ne 0 ] && root="$1"
echo $root

traverse $root ""
echo

    
if [ $dir_count -ne 2 ] && [ $file_count -ne 1 ]
then
    echo "$(($dir_count - 1)) directories, $file_count files"
    
elif [ $dir_count -eq 2 ] && [ $file_count -eq 1 ] 
then
    echo "$(($dir_count - 1)) directory, $file_count file"
    elif [ $dir_count -eq 2 ] && [ $file_count -ne 1 ]
then
    echo "$(($dir_count - 1)) directory, $file_count files"
elif [ $dir_count -ne 2 ] && [ $file_count -eq 1 ]
then
    echo "$(($dir_count - 1)) directories, $file_count file" 
fi
shopt -u nullglob

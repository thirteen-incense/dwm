#!/bin/bash
let n=0
files=($HOME/wallpapers/*.*)
count=${#files[@]}
while [ 1 ]
do
#  let "n=n%$count"
  let "n=$((RANDOM %count))"
  file="${files[$n]}"
#  echo "switch to $file"
  feh --bg-fill "$file" &
#  let n=n+1
#  sleep 5s
  sleep 1m
done

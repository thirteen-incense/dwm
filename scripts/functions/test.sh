#!/bin/sh

file=".netarte"

if [ ! -f "$file" ]; then
  RX_pre=0
fi


RX_next=$(ifconfig wlan0 | grep 'RX packets' | awk '{print $5}')
TX=$(ifconfig wlan0 | grep 'RX packets' | awk '{print $5}')



cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}

printf "%s" "$cache"

#!/bin/sh

dwm_memcpu(){

cpu=`top -b -n1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' '{split($1, vs, ","); v=vs[length(vs)]; sub(/\s+/, "", v);sub(/\s+/, "", v); printf "%d", 100-v;}'`

mem=$(free -m | sed -n '2p' | awk '{print $7}')

mem_used_persent=`free -m | awk -F '[ :]+' 'NR==2{printf "%d", ($2-$7)/$2*100}'`

printf "%s|%sM" "$cpu%" "$mem"
}

#!/bin/sh

dwm_light(){

max_light=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)
light=$(cat /sys/class/backlight/amdgpu_bl0/brightness)
light_status=☀:$(echo $light $max_light | awk '{printf "%d\n",$1/$2*100}')

printf "%s" "$light_status"
}

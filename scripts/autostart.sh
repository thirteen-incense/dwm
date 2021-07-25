#!/bin/sh

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

. "$DIR/functions/dwm_battery.sh"
. "$DIR/functions/dwm_locktime.sh"
. "$DIR/functions/dwm_alsa.sh"
. "$DIR/functions/dwm_light.sh"
. "$DIR/functions/dwm_memcpu.sh"
. "$DIR/functions/dwm_NetRraf.sh"
. "$DIR/functions/dwm_wifistate.sh"
. "$DIR/functions/dwm_ipaddr.sh"

#while true; do
#	dwm_resources
#done &

picom &
clash &

export FZF_DEFAULT_OPTS='--no-height --no-reverse'

while true; do
#	xsetroot -name " [$(< .resources)] [$(dwm_battery)] [$(dwm_alsa)] [$(dwm_date)] "
    xsetroot -name "$(dwm_NetRraf)|$(dwm_memcpu)|$(dwm_ipaddr)|$(dwm_locktime)|$(dwm_light)|$(dwm_alsa)|$(dwm_battery)|$(dwm_wifistate)"
	sleep 1
done

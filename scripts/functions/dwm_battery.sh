#!/bin/sh

dwm_battery () {
    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

	if [ "$STATUS" = "Charging" ]; then
		printf ":%s%%" "$CHARGE"
	elif [ "$STATUS" = "Full" ]; then
	    printf ":%s%%" "$CHARGE"
    else
        printf ":%s%%" "$CHARGE"
	fi
}

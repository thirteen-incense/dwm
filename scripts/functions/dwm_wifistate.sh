#!/bin/sh

dwm_wifistate() {
    State=$(iwctl station wlan0 show | grep State | awk '{print $2}')

    if [ "$State" = "connected" ]; then
        printf "✓"
    elif [ "$State" = "disconnected" ]; then
        printf "✗"
    else
        printf "○"
    fi
}

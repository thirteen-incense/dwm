#!/bin/sh

dwm_ipaddr() {
    ipaddr=$(ip addr | grep wlan0 | grep inet | awk '{print $2}' | cut -d '/' -f1)
    printf "%s" $ipaddr
}

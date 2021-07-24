#!/bin/sh

id=`xinput list | grep "Touchpad" | cut -d'=' -f2 | cut -d'[' -f1`

flag=`xinput list-props $id | grep "Device Enabled " | cut -c 24-24`
if
  [ "$flag" = 0 ]; then
  n=1
else
  n=0
fi

xinput set-prop $id "Device Enabled" $n




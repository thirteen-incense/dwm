#!/bin/sh

dwm_locktime(){

clock=$(date '+%I')

case "$clock" in
	"00") clock_icon="🕛" ;;
	"01") clock_icon="🕐" ;;
	"02") clock_icon="🕑" ;;
	"03") clock_icon="🕒" ;;
	"04") clock_icon="🕓" ;;
	"05") clock_icon="🕔" ;;
	"06") clock_icon="🕕" ;;
	"07") clock_icon="🕖" ;;
	"08") clock_icon="🕗" ;;
	"09") clock_icon="🕘" ;;
	"10") clock_icon="🕙" ;;
	"11") clock_icon="🕚" ;;
	"12") clock_icon="🕛" ;;
esac

#printf $(date +":%Y-%m-%d %u,${clock_icon}:%H:%M")

printf ":%s|${clock_icon}:%s" "$(date '+%Y-%m-%d %u')" "$(date +%H:%M)"
}

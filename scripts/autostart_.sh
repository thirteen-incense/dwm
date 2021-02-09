#!/bin/bash
while true
do

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

LOCALTIME=$(date +":%Y-%m-%d %u,${clock_icon}:%H:%M")


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


vol=$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')

if [ "$vol" -eq "0" ]; then
    icon="🔇"
elif [ "$vol" -gt "70" ]; then
	icon="🔊"
elif [ "$vol" -lt "30" ]; then
	icon="🔈"
else
	icon="🔉"
fi

vol_status="$icon:$vol%"


update() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

#[ew]*
RX=$(update /sys/class/net/wlan0/statistics/rx_bytes)
TX=$(update /sys/class/net/wlan0/statistics/tx_bytes)

# 换算单位
if [[ $RX -lt 1024 ]];then
    # 如果接收速率小于1024,则单位为B/s
    RX="${RX}B/s"
elif [[ $RX -gt 1048576 ]];then
    # 否则如果接收速率大于 1048576,则改变单位为MB/s
    RX=$(echo $RX | awk '{print $1/1048576 "MB/s"}')
    RX=$(printf "%.2fMB/s" $RX)
else
    # 否则如果接收速率大于1024但小于1048576,则单位为KB/s
    RX=$(echo $RX | awk '{print $1/1024 "KB/s"}')
    RX=$(printf "%.2fKB/s" $RX)
fi

# 换算单位
if [[ $TX -lt 1024 ]];then
    # 如果发送速率小于1024,则单位为B/s
    TX="${TX}B/s"
elif [[ $TX -gt 1048576 ]];then
    # 否则如果发送速率大于 1048576,则改变单位为MB/s
    TX=$(echo $TX | awk '{print $1/1048576 "MB/s"}')
    TX=$(printf "%.2fMB/s" $TX)
else
    # 否则如果发送速率大于1024但小于1048576,则单位为KB/s
    TX=$(echo $TX | awk '{print $1/1024 "KB/s"}')
    TX=$(printf "%.2fKB/s" $TX)
fi

#TX_f=$(printf "%.2" $TX)
#RX_f=$(printf "%.2" $RX)

NetRraf="⏫:$TX ⏬:$RX"


#free --mebi | sed -n '2{p;q}' | awk '{printf ("🧠:%2.2fGB/%2.2fGB\n", ( $3 / 1024), ($2 / 1024))}'




CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)



total=$(free -m | sed -n '2p' | awk '{print $2}')
used=$(free -m | sed -n '2p' | awk '{print $3}')
free=$(free -m | sed -n '2p' | awk '{print $4}')
shared=$(free -m | sed -n '2p' | awk '{print $5}')
buff=$(free -m | sed -n '2p' | awk '{print $6}')
available=$(free -m | sed -n '2p' | awk '{print $7}')


max_light=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)
light=$(cat /sys/class/backlight/amdgpu_bl0/brightness)
light_status=☀:$(echo $light $max_light | awk '{printf "%d\n",$1/$2*100}')


# 得到ip
ip=`ip addr show eth0 | awk ' !/127.0.0.1/ && /inet/ { gsub(/\/.*/, "", $2); print ""$2 }'`
#echo $ip
ip_index=`echo $ip | awk -F '.' '{print $4}'`

#计算cpu使用率
cpu=`top -b -n1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' '{split($1, vs, ","); v=vs[length(vs)]; sub(/\s+/, "", v);sub(/\s+/, "", v); printf "%d", 100-v;}'`
#echo $cpu

#统计内存使用率
mem_used_persent=`free -m | awk -F '[ :]+' 'NR==2{printf "%d", ($2-$7)/$2*100}'`
#echo $mem_used_persent


xsetroot -name "${NetRraf},${available}M,${cpu}%,${LOCALTIME},${light_status}%,${vol_status},$(dwm_battery)"
sleep 1
done

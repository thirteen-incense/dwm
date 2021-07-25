#!/bin/bash

dwm_NetRraf(){
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
elif [[ $RX -lt 0 ]];then
    RX="0B/s"
elif [[ $RX -gt 1048576 ]];then
    # 否则如果接收速率大于 1048576,则改变单位为MB/s
    RX=$(echo $RX | awk '{print $1/1048576}')
    RX=$(printf "%.2fMB/s" $RX)
else
    # 否则如果接收速率大于1024但小于1048576,则单位为KB/s
    RX=$(echo $RX | awk '{print $1/1024}')
    RX=$(printf "%.2fKB/s" $RX)
fi

# 换算单位
if [[ $TX -lt 1024 ]];then
    # 如果发送速率小于1024,则单位为B/s
    TX="${TX}B/s"
elif [[ $TX -lt 0 ]];then
    TX="0B/s"
elif [[ $TX -gt 1048576 ]];then
    # 否则如果发送速率大于 1048576,则改变单位为MB/s
    TX=$(echo $TX | awk '{print $1/1048576}')
    TX=$(printf "%.2fMB/s" $TX)
else
    # 否则如果发送速率大于1024但小于1048576,则单位为KB/s
    TX=$(echo $TX | awk '{print $1/1024}')
    TX=$(printf "%.2fKB/s" $TX)
fi

NetRraf="⏫:$TX|⏬:$RX"



    printf "%s" "$NetRraf"
}

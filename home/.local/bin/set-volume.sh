#!/bin/sh
# volume.sh - script to control volume and show notification
# Usage: volume.sh {--up|--down|--mute}
ICON_BASE_PATH="/usr/share/icons/Qogir-dark/24/actions"

value_icon() {
    if [ "$1" -lt 33 ]; then
        echo "${ICON_BASE_PATH}/audio-volume-low.svg"
    elif [ "$1" -lt 66 ]; then
        echo "${ICON_BASE_PATH}/audio-volume-medium.svg"
    else
        echo "${ICON_BASE_PATH}/audio-volume-high.svg"
    fi
}

get_value() {
    echo "$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')"
}

notify() {
    dunstctl close-all
    notify-send -t 1000 \
        -h "int:value:${1}" \
        -i "$(value_icon ${1})" \
        "Volume: ${1}%"
}

up() {
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    notify "$(get_value)"
}

down() {
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    notify "$(get_value)"
}

mute() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    dunstctl close-all
    if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | grep -e 'yes')" ];then
        notify-send -t 1000 -h "int:value:0" \
            -i "${ICON_BASE_PATH}/audio-volume-muted.svg" \
            "Volume: Muted"
    else
        notify "$(get_value)"
    fi
}

case "$1" in
    --up)
        up
        ;;
    --down)
        down
        ;;
    --mute)
        mute
        ;;
    *)
        echo "Usage: $0 {--up|--down|--mute}"
esac

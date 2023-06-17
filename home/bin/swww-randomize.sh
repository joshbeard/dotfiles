#!/bin/bash

# Set a random wallpaper with 'swww' at regular intervals from a directory of
# images. This sets a different wallpaper for each monitor.

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals

# This controls (in seconds) when to switch to the next image
INTERVAL=600
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2


if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 <dir containg images>"
	exit 1
fi

get_display_name() {
    segment=$(echo "$1" | grep -o "Monitor \([^ ]*\)" | awk '{print $2}')
    echo "$segment"
}

get_random_image() {
    echo "$1" | while read -r img; do
        rnd="$((RANDOM % 1000))"
        echo "$rnd:$img"
    done \
        sort -n | cut -d':' -f2- | head -n1

}

while true; do
    # Get the file list once per rotation.
    images=$(find "$1" -maxdepth 1 -type f -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png')
    # Check the connected monitors each time.
    monitors=$(hyprctl monitors | grep "^Monitor")
    IFS=$'\n'
    for monitor in $monitors; do
        display=$(get_display_name "$monitor")
        img=$(get_random_image "$images")
        echo "Setting $img as wallpaper for $display"
        swww img "$img" --outputs "$display"
    done
    sleep $INTERVAL
done

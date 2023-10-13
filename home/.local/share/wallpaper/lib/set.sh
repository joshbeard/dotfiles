#!/usr/bin/env bash
# Set a random wallpaper with 'swww' at regular intervals from a directory of
# images. This sets a different wallpaper for each monitor.

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals

# Defaults
interval=600

source "$HOME/.local/share/wallpaper/etc/wallpaper.cfg"
source "$HOME/.local/share/wallpaper/lib/common.sh"

if [ "$XDG_SESSION_TYPE" == "x11" ]; then
    source "${lib_dir}/x_xorg.sh"
else
    source "${lib_dir}/x_wayland.sh"
fi

# Initialize flags and variables
once_flag=false
display_flag=false
display= # Default display value
list=""

usage() {
    echo "set.sh - Set a random wallpaper at regular intervals from a directory of images."
    echo
    echo "Usage: $0 [--once] [--interval <seconds>] [-d, --display <digit>] <dir containing images>"
    echo "  --once        Set the wallpaper once and exit."
    echo "  --interval <seconds>  Set the interval between wallpaper changes."
    echo "  -l|--list <list>      Set wallpaper from a list of images."
    echo "  -d, --display <digit> Specify a single digit for display."
    echo "  -h, --help    Display this help message."
    echo "  <dir containing images>  Specify a directory containing images."
    exit 1
}


# Process command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --once)
            once_flag=true
            shift
            ;;
        --interval)
            interval_flag=true
            if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
                interval="$2"
                shift 2
            else
                echo "Error: --interval requires a positive integer argument."
                exit 1
            fi
            ;;
        -d|--display)
            display_flag=true
            if [[ -n "$2" && "$2" =~ ^[0-9]$ ]]; then
                display="$2"
                shift 2
            else
                echo "Error: -d, --display requires a single digit argument."
                exit 1
            fi
            ;;
        -l|--list)
            if [[ -n "$2" && "$2" =~ ^[0-9]$ ]]; then
                list="$2"
                shift 2
            else
                echo "Error: -l, --list requires an argument."
                exit 1
            fi
        -h|--help)
            usage
            ;;
        *)
            if [[ -d "$1" ]]; then
                wallpaper_dir="$1"
            else
                echo "Error: Invalid argument: $1"
                usage
                exit 1
            fi
            shift
            ;;
    esac
done

if [[ -z "$wallpaper_dir" ]]; then
    echo "Usage: $0 [--once] [--interval <seconds>] [-d, --display <digit>] <dir containing images>"
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
    done |   sort -n | cut -d':' -f2- | head -n1
}

while true; do
    monitors=$(get_monitors)

    if [ -n "$list" ]; then
        images=$(cat "$list")
    else
        images=$(find "$wallpaper_dir" -maxdepth 1 -type f -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png')
    fi

    log_debug "found $(echo "$images" | wc -l) images"

    IFS=$'\n'
    displaynum=0

    if [ -f "$currently_set_file" ]; then
        rm -f "$currently_set_file"
        touch "$currently_set_file"
    fi

    for monitor in $monitors; do
        displaynum=$((displaynum+1))
        current_display=$(get_display_name "$monitor")
        img=""

        if [ "$display_flag" = true ] && [ "$displaynum" != "$display" ]; then
            log_debug "Skipping display $displaynum"
            continue
        fi

        x=0
        while [ $x -lt 10 ]; do
            if [ "$XDG_SESSION_TYPE" == "x11" ]; then
                current_display=$((displaynum-1))
            fi

            img=$(get_random_image "$images")

            # Check if the image is in the list of last wallpapers and skip it if it is.
            grep -q "$img" "$track_file" && echo "Skipping $img because it was recently set" && continue

            x=$((x+1))

            set_wallpaper "$display" "$img" && break
            sleep 1

        done

        # Add the image to the list of last wallpapers. Keep 1000 lines in the file.
        if [ -n "$img" ]; then
            echo "$img" >> "$track_file"
            tail -n 1000 "$track_file" > "$track_file.tmp"
            mv "$track_file.tmp" "$track_file"
        fi

        echo "${displaynum}:${img}" >> "$currently_set_file"
        log_info "Display $displaynum set to: $img"
    done

    if [ "$once_flag" = true ]; then
        break
    fi

    sleep "$interval"
done



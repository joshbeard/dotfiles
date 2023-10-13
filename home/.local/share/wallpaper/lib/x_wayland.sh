#!/usr/bin/env bash

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2

check_required_command swww hyprctl

# Function to set wallpaper for a specific display
# Arguments:
#   display: The display to set the wallpaper for
#   img: The image to set as wallpaper
set_wallpaper() {
    swww img "$img" --outputs "$display" || return 1
}

# Function to get the list of monitors
get_monitors() {
    echo hyprctl monitors | grep "^Monitor"
}

# Function to get the current wallpaper
# Arguments:
#   display: The display to get the wallpaper for
get_current_wallpaper() {
    display="$1"
    query=$(swww query | head -n "$display" | tail -n 1)
    echo "$query" | awk -F 'image: ' '{print $2}'
}

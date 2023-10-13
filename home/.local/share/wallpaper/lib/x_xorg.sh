#!/usr/bin/env bash

check_required_command nitrogen xrandr

# Function to set wallpaper for a specific display
# Arguments:
#   display: The display to set the wallpaper for
#   img: The image to set as wallpaper
set_wallpaper() {
    display="$1"
    img="$2"
    nitrogen --head=$display --set-zoom-fill  "$img" || return 1
}

# Function to get the list of monitors
get_monitors() {
    mons=$(xrandr --listactivemonitors | grep "^ " | awk '{print $1}')
    echo "$mons"
}

# Function to get the current wallpaper
# Arguments:
#   display: The display to get the wallpaper for
get_current_wallpaper() {
    display="$1"
    log_info "Getting current wallpaper for display $display from $currently_set_file"
    if [ -f "$currently_set_file" ]; then
        for line in $(cat "$currently_set_file"); do
            log_debug "Checking line: $line"
            if [[ "$line" =~ ^$display: ]]; then
                image=$(echo "$line" | awk -F ':' '{print $2}')
                log_debug "Found image: $image"
                echo "$image"
                return
            fi
        done
    else
        log_error "No wallpaper set on display $display"
        log_error "$currently_set_file does not exist"
        exit
    fi
}

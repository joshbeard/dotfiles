#!/usr/bin/env bash
# Set a random wallpaper with 'swww' at regular intervals from a directory of
# images. This sets a different wallpaper for each monitor.

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals

source "$HOME/.local/share/wallpaper/etc/walls.cfg"
source "$HOME/.local/share/wallpaper/lib/common.sh"

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=2

# Initialize flags and variables
once_flag=false
interval_flag=false
display_flag=false
display= # Default display value

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
        INTERVAL="$2"
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
    *)
      if [[ -d "$1" ]]; then
        image_dir="$1"
      else
        echo "Error: Invalid argument: $1"
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ -z "$image_dir" ]]; then
  echo "Usage: $0 [--once] [--interval <seconds>] [-d, --display <digit>] <dir containing images>"
  exit 1
fi

check_required_command swww hyprctl

get_display_name() {
  segment=$(echo "$1" | grep -o "Monitor \([^ ]*\)" | awk '{print $2}')
  echo "$segment"
}

get_random_image() {
  echo "$1" | while read -r img; do
    rnd="$((RANDOM % 1000))"
    echo "$rnd:$img"
  done \
  |   sort -n | cut -d':' -f2- | head -n1
}

# Function to set wallpaper for a specific display
set_wallpaper_for_display() {
  local display="$1"
  local img="$2"
  echo "Setting $img as wallpaper for display $display"
  swww img "$img" --outputs "$display" || return 1
}

while true; do
  # Get the file list once per rotation.
  images=$(find "$image_dir" -maxdepth 1 -type f -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png')
  # Check the connected monitors each time.
  monitors=$(hyprctl monitors | grep "^Monitor")
  IFS=$'\n'
  displaynum=0
  for monitor in $monitors; do
    displaynum=$((displaynum+1))
      echo "Monitor: $monitor"
    current_display=$(get_display_name "$monitor")
    img=""
    if [ "$display_flag" = true ] && [ "$displaynum" != "$display" ]; then
        echo "display_flag=${display_flag} displaynum=${displaynum} display=${display}"
      continue  # Skip this iteration if the display doesn't match the specified one.
    fi

    x=0
    while [ $x -lt 10 ]; do
      img=$(get_random_image "$images")

      echo "Trying $img"
      # Check if the image is in the list of last wallpapers and skip it if it is.
      grep -q "$img" "$TRACK_FILE" && echo "Skipping $img" && continue

      x=$((x+1))

      set_wallpaper_for_display "$current_display" "$img" && break
      sleep 1
    done

    # Add the image to the list of last wallpapers. Keep 1000 lines in the file.
    if [ -n "$img" ]; then
      echo "$img" >> "$TRACK_FILE"
      tail -n 1000 "$TRACK_FILE" > "$TRACK_FILE.tmp"
      mv "$TRACK_FILE.tmp" "$TRACK_FILE"
    fi
  done

  if [ "$once_flag" = true ]; then
    break
  fi

  if [ "$interval_flag" = true ]; then
    sleep "$INTERVAL"
  else
    sleep "$DEFAULT_INTERVAL"
  fi
done


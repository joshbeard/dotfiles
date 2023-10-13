#!/usr/bin/env bash
# Adds the image(s) to a favorites file.
# Images can be specified as arguments or by specifying a display to query.
source "$HOME/.local/share/wallpaper/etc/wallpaper.cfg"
source "$HOME/.local/share/wallpaper/lib/common.sh"

if [ "$XDG_SESSION_TYPE" == "x11" ]; then
    source "${lib_dir}/x_xorg.sh"
else
    source "${lib_dir}/x_wayland.sh"
fi

usage() {
  echo "add.sh - Adds wallpaper images to list."
  echo
  echo "Usage: $0 [DISPLAY|<file1> <file2>...] LIST"
  echo "  <digit>               Specify a single digit for display."
  echo "  <list>                Specify a list name to add to."
  echo "  <file1> <file2> ...   Specify one or more file paths."
  echo
  echo "Example:"
  echo "  $0 1 favs"
  exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

images="$@"
first_arg="$1"
last_arg="${@: -1}"
list_name="$last_arg"

# If a display is specified, get the wallpaper that's currently set on that
# using 'swww query'.
if [[ "$1" =~ ^[0-9]+$ ]]; then
    display="$1"
    if [ "$display" -eq 0 ]; then
        display=1
    fi

    wallpaper=$(get_current_wallpaper "$display")

    if [ -z "$wallpaper" ]; then
        echo "No wallpaper set on display $display"
        exit
    fi

    post_run_cmd="${post_run_cmd} --display $display"

    images="$wallpaper"
fi

if [ ! -f "$favorites_file" ]; then
    touch "$favorites_file"
fi

echo "images: $images"

IFS=$'\n'
for image in $images; do
    if [ ! -f "$image" ]; then
        echo "File not found: $image"
        continue
    fi

    if [ ! -d "$lists_dir" ]; then
        mkdir -p "$lists_dir"
    fi

    echo "Adding $image to list ${lists_dir}/${list_name}.txt"

    echo "$image" >> "${lists_dir}/${list_name}.txt"
done

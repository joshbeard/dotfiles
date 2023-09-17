#!/usr/bin/env bash
# Adds the image(s) to a blacklist file with their md5sums and deletes them
# from disk.
# Images can be specified as arguments or by specifying a display to query.
#
# Blacklist file format: <md5sum>::<image path>
# Example: 1234567890abcdef::/home/user/image.jpg

source "$HOME/.local/share/wallpaper/etc/wallpaper.cfg"
source "$HOME/.local/share/wallpaper/lib/common.sh"

usage() {
  echo "wall-blacklist.sh - Adds wallpaper images to the blacklist."
  echo
  echo "Usage: $0 [<display>] [<file1> <file2> ...]"
  echo "  <digit>               Specify a single digit for display."
  echo "  <file1> <file2> ...   Specify one or more file paths."
  exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

check_required_command md5sum swww

images="$@"

# If a display is specified, get the wallpaper that's currently set on that
# using 'swww query'.
if [ "$#" -eq 1 ]; then
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        display="$1"
        if [ "$display" -eq 0 ]; then
            display=1
        fi

        query=$(swww query | head -n "$display" | tail -n 1)
        image=$(echo "$query" | awk -F 'image: ' '{print $2}')

        echo "Display $display: $image"

        if [ -z "$image" ]; then
            echo "No wallpaper set on display $display"
            exit
        fi

        post_run_cmd="${post_run_cmd} --display $display"

        images="$image"
    fi
fi

if [ ! -f "$blacklist_file" ]; then
    touch "$blacklist_file"
fi

IFS=$'\n'
for image in $images; do
    if [ ! -f "$image" ]; then
        echo "File not found: $image"
        continue
    fi

    md5sum=$(md5sum "$image" | cut -d ' ' -f 1)
    echo "$md5sum::$image" >> "$blacklist_file"

    rm -f "$image"
done

if [ -n "$post_run_cmd" ]; then
    echo "Running post-run command: $post_run_cmd"
    eval "$post_run_cmd"
fi

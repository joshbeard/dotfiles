#!/usr/bin/env bash
source "$HOME/.local/share/wallpaper/etc/wallpaper.cfg"
source "$HOME/.local/share/wallpaper/lib/common.sh"

libdir="$HOME/.local/share/wallpaper/lib"
cmd="$1"

usage() {
    echo "walls.sh - Manage wallpaper images on X and Wayland"
    echo
    echo "Download, set, randomize, blacklist and add wallpapers to lists."
    echo
    echo "Usage: $(basename $0) SUBCOMMAND [SUBCOMMAND OPTIONS]"
    echo
    echo "Subcommands:"
    echo "  help      - Show this help message."
    echo "  set       - Set wallpaper(s) and exit."
    echo "  start     - Start the wallpaper randomizer."
    echo "  blacklist - Blacklist the current wallpaper."
    echo "  download  - Download wallpapers."
    echo "  add       - Add a wallpaper to a list."
    echo "  view      - View the wallpaper set."
    echo
    exit 1
}

case $cmd in
    help)
        usage
        ;;
    set)
        shift
        $libdir/set.sh --once $@
        ;;
    start)
        shift
        $libdir/set.sh $@
        ;;
    blacklist)
        shift
        $libdir/add.sh $@ blacklist
        ;;
    download)
        shift
        $libdir/get.sh $@
        ;;
    add)
        shift
        $libdir/add.sh $@
        ;;
    view)
        # Check if a second argument is provided (display)
        if [ -z "$2" ]; then
            echo "specify a display"
            exit 1
        fi

        display="$2"
        echo grep "^$display:" "$currently_set_file" | awk -F ':' '{print $2}'
        current=$(grep "^$display:" "$currently_set_file" | awk -F ':' '{print $2}')
        if [ -z "$current" ]; then
            echo "No wallpaper set on display $display"
            exit 1
        fi
        echo "Current wallpaper: $current"
        feh "$current"
        ;;
    *)
        usage
        ;;
esac

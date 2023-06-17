#!/bin/sh

handle() {
  case $1 in monitoradded*)
    # Move workspaces to monitors
    # hyprctl dispatch moveworkspacetomonitor "1 1"
    # hyprctl dispatch moveworkspacetomonitor "2 1"
    # hyprctl dispatch moveworkspacetomonitor "4 1"
    # hyprctl dispatch moveworkspacetomonitor "5 1"

    # Reload eww
    eww reload -c ~/.config/eww/bar

    notify-send -t 1000 "Monitor connected"
  esac
}

socat - UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock | while read -r line; do handle "$line"; done

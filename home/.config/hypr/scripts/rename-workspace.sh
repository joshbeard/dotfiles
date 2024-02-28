#!/bin/bash

current_id=$(hyprctl activeworkspace | grep -oP 'ID \K\w+')

name=$(rofi -dmenu -p "Rename workspace" \
    -lines 1 \
    -eh 1 \
    -theme /usr/share/rofi/themes/dracula2.rasi \
    -kb-cancel "Escape" \
    -kb-accept-entry "Return" \
    -custom-1 "rename_workspace")

if [ -z "$name" ]; then
    exit 0
fi

hyprctl dispatch renameworkspace "${current_id} ${name}"

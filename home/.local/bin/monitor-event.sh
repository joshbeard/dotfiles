#!/bin/bash
# Script to automatically change monitor layout based on connected monitors.
# This script is called by the 'srandrd' daemon and uses 'xrandr' to change
# the layout.
DISPLAY=:0.0
PRIMARY=eDP-1

# Define corresponding layout scripts as an associative array
declare -A LAYOUTS=(
  ["eDP-1"]="${HOME}/.screenlayout/laptop-only.sh"
  ["eDP-1 HDMI-1"]="${HOME}/.screenlayout/workbench-2.sh"
  ["eDP-1 HDMI-1 HDMI-2"]="${HOME}/.screenlayout/workbench-3.sh"
  ["eDP-1 HDMI-2 HDMI-1"]="${HOME}/.screenlayout/workbench-3-alt.sh"
)

# Get the list of active monitors
active_monitors=$(xrandr | grep " connected" | awk '{print $1}')
active_monitors=$(echo ${active_monitors})

echo "Active monitors: |${active_monitors}|"
notify-send "Active monitors: ${active_monitors}"

# Check if the active configuration matches any defined configuration
for config in "${!LAYOUTS[@]}"; do
  if [[ "${active_monitors}" == "${config}" ]]; then
    layout="${LAYOUTS[${config}]}"
    if [[ -n "${layout}" && -f "${layout}" ]]; then
      echo "Executing ${layout}"
      "${layout}"
    else
      echo "No script found for this configuration: ${config}"
    fi
    exit
  fi
done

# If no matching configuration is found, enable auto layout
echo "No script for this configuration"

PREVIOUS=$PRIMARY
for monitor in ${active_monitors}; do
  if [[ "${monitor}" != "${PRIMARY}" ]]; then
    echo "Executing xrandr --output ${monitor} --auto --right-of ${PREVIOUS}"
    xrandr --output "${monitor}" --auto --right-of "${PREVIOUS}"
    PREVIOUS=$monitor
  fi
done


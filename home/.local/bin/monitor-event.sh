#!/usr/bin/env bash
# joshbeard's monitor layout script for X11/Xorg
# =============================================================================
# Script to automatically change monitor layout based on connected monitors.
# This script is called by the 'srandrd' daemon and uses 'xrandr' to change
# the layout.
#
# This is for X11/Xorg only. It will not work with Wayland. In Wayland, the
# compositor is responsible for managing the monitor layout.
#
# I use this with laptops that move between different workstations with
# different monitor setups. The script will automatically detect the
# connected monitors and apply the appropriate layout.
#
# The monitor configuration is uniquely identified based on the EDIDs of the
# connected monitors. The hashed EDIDs are mapped to a friendly name and a
# corresponding layout script (e.g. saved by 'arandr') to apply the layout.
#
# Perhaps there's something out there that already does this in a fairly
# agnostic sort of way?

# ----------------------------------------------------------------------------
# Configuration

# Define corresponding layout scripts as an associative array.
# The hash is the MD5 hash of the EDID of the connected monitors. Run this
# script manually to get the hash for the current configuration.
declare -A LAYOUTS=(
  ["223632c428784fecaaa3e2a6aaaf6d8e"]="No monitors:${HOME}/.screenlayout/laptop-only.sh"
  ["5564e8f6c8dacb3fca826f532ff7ef73"]="Workbench Single:${HOME}/.screenlayout/workbench-single.sh"
  ["01f4f05ff5dd5f5311b1d55e60330048"]="Workbench Dual:${HOME}/.screenlayout/workbench-dual.sh"
)

# Primary monitor when using auto-layout for unknown configurations.
declare PRIMARY=eDP-1

# Path to an icon to use in the desktop notification.
declare NOTIFY_ICON=/usr/share/icons/candy-icons/preferences/scalable/preferences-desktop-display.svg

# ----------------------------------------------------------------------------
# Functions

# Function to extract the unique identifier (serial number or part of EDID) of
# a monitor.
get_monitor_id() {
  local monitor_name="$1"
  local edid_full
  local edid_hash
  # Get the full EDID block
  edid_full=$(xrandr --verbose | awk "/^${monitor_name} connected/,/EDID/" | grep -v "EDID" | grep -o "[0-9a-fA-F]{32}")
  # Hash the EDID to get a consistent unique identifier
  edid_hash=$(echo "${edid_full}" | md5sum | awk '{print $1}')
  echo "${edid_hash}"
}

# Function to generate a unique identifier for the current monitor, comprised
# of the unique identifiers of all connected monitors.
generate_config_id() {
  local config_id=""
  local connected_monitors
  connected_monitors=$(xrandr | grep " connected" | awk '{print $1}')
  for monitor in ${connected_monitors}; do
    config_id+=$(get_monitor_id $monitor)
  done
  echo "${config_id}" | md5sum | awk '{print $1}'
}

# ----------------------------------------------------------------------------
# Main execution
config_id=$(generate_config_id)
layout_script=""
friendly_name=""

# Look for a script matching the configuration ID
for hash in "${!LAYOUTS[@]}"; do
  if [[ "${config_id}" == *"${hash}"* ]]; then
    IFS=':' read -r friendly_name layout_script <<< "${LAYOUTS[${hash}]}"
    logger -t monitor-event.sh "Found matching entry for ${friendly_name} (${hash})"
    break
  fi
done

if [ -n "${layout_script}" ]; then
  if [ ! -f "${layout_script}" ]; then
    logger -t monitor-event.sh "Layout script not found: ${layout_script}"
    exit 1
  fi

  logger -t monitor-event.sh "Executing layout for ${friendly_name} using script ${layout_script}"
  echo "Executing layout for ${friendly_name} using script ${layout_script}"
  notify-send -i "$NOTIFY_ICON" "Monitor layout changed to ${friendly_name}"
  bash "${layout_script}"
  exit $?
fi

# ----------------------------------------------------------------------------
# Fallback to auto-layout
PREVIOUS=$PRIMARY
logger -t monitor-event.sh "No layout script found for ${config_id}. Using auto-layout."
for monitor in ${active_monitors}; do
  if [[ "${monitor}" != "${PRIMARY}" ]]; then
    echo "Executing xrandr --output ${monitor} --auto --right-of ${PREVIOUS}"
    echo xrandr --output "${monitor}" --auto --right-of "${PREVIOUS}"
    PREVIOUS=$monitor
  fi
done

echo "No layout script found for the current monitor configuration."
echo "Current configuration ID: ${config_id}"
echo "Add the following entry to the LAYOUTS array in the script:"
echo "[\"${config_id}\"]=\"ThisConfigName:path/to/your/layout_script.sh\""

notify-send -i "$NOTIFY_ICON" "Monitor layout not found for config ${config_id}"

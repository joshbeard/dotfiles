#!/bin/sh
# Simple script to query the battery status to display in the tmux status bar.
# It should return the percentage of battery remaining without a percent sign.
#
# For the mac, it uses the relative 'batt.rb' ruby script
# For Linux, it obtains the capacity from /sys/

bat_pct() {
  echo "$1" | grep -oP '(?<=, )\d+(?=%)'
}

case `uname -s` in
  Darwin)
    /usr/bin/pmset -g batt | ~/bin/batt.rb
  ;;
  Linux)
    # Determine what our battery status is
    vendor=$(cat /sys/devices/virtual/dmi/id/board_vendor)

    case $vendor in
      Apple\ Inc*)
        # MacBook Pro (2015)
        if command -v acpi >/dev/null; then
          bat0=$(acpi -b 2>&1 | grep 'Battery 0')
          # If bat0 output matches "unknown", try bat1
          # Otherwise, just use BAT0
          if [[ $bat0 =~ "unavailable" ]]; then
            bat_pct "$(acpi -b 2>&1 | grep 'Battery 1')"
          else
            bat_pct "$bat0"
          fi
        else
          cat /sys/class/power_supply/BAT0/capacity
        fi
        ;;
      Acer*)
        # Acer Netbook
        cat /sys/class/power_supply/BAT1/capacity
        ;;
      *)
        # Just run otherwise
        echo '?'
    esac
  ;;
  *)
    echo '?'
  ;;
esac


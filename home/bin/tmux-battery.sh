#!/bin/sh
# Simple script to query the battery status to display in the tmux status bar.
# It should return the percentage of battery remaining without a percent sign.
#
# For the mac, it uses the relative 'batt.rb' ruby script
# For Linux, it obtains the capacity from /sys/

case `uname -s` in
  Darwin)
    /usr/bin/pmset -g batt | ~/bin/batt.rb
  ;;
  Linux)
    # My netbook's battery
    if [ -f "/sys/class/power_supply/BAT1/capacity" ]; then
      /usr/bin/cat /sys/class/power_supply/BAT1/capacity
    fi
  ;;
  *)
  ;;
esac


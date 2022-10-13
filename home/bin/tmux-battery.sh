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
    # Determine what our battery status is
    vendor=$(cat /sys/devices/virtual/dmi/id/board_vendor)

    case $vendor in
      Apple\ Inc*)
        # MacBook Pro (2015)
        cat /sys/class/power_supply/BAT0/capacity
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


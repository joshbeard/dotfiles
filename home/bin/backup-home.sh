#!/usr/bin/env bash
# Wrapper script for sysbackup
# https://github.com/joshbeard/sysbackup
#
# This backs up my home directory.

SYSBACKUP=${HOME}/.local/sysbackup/sysbackup.sh
CONFIG=${HOME}/.config/sysbackup/home.conf

# Determine what our battery status is
vendor=$(cat /sys/devices/virtual/dmi/id/board_vendor)

case $vendor in
  Apple\ Inc*)
    # MacBook Pro (2015)
    ON_BATTERY=$(cat /sys/class/power_supply/ADP1/online)
    ;;
  Acer*)
    # Acer Netbook
    ON_BATTERY=$(cat /sys/class/power_supply/ACAD/online)
    ;;
  *)
    # Just run otherwise
    ON_BATTERY=1
esac

if [ "$ON_BATTERY" == "0" ]; then
  logger -t backup_josh -s "On battery power, skipping backup"
  exit 0
fi

notify-send -t 2500 -a Sysbackup -u normal "Starting backup of home."

# Local directory in home to backup assorted things outside our home that
# we might own (crontab)
[ ! -d "${HOME}/.backups" ] && mkdir "${HOME}/.backups"

logger -t backup_josh -s "Backing up crontab to ${HOME}/.backups/crontab"
crontab -l >| "${HOME}/.backups/crontab"

# Run sysbackup with config
${SYSBACKUP} --config ${CONFIG}

notify-send -t 2500 -a Sysbackup -u normal "Backup complete."


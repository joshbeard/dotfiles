#!/usr/bin/env bash
set -e
# Wrapper script for sysbackup
# https://github.com/joshbeard/sysbackup
#
# This backs up my home directory.

SYSBACKUP=${HOME}/.local/sysbackup/sysbackup.sh
CONFIG=${HOME}/.config/sysbackup/home.conf
SKIP_ON_BATTERY=false

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

if [ "$ON_BATTERY" == "0" ] && [ "$SKIP_ON_BATTERY" == "true" ]; then
  logger -t backup_josh -s "On battery power, skipping backup"
  exit 0
fi


set -a
#eval $(ssh-agent -s)
logger -t backup_josh -s "Starting backup of home with config ${CONFIG}"

# Test SSH connection to NFS server
logger -t backup_josh -s "Testing SSH connection to NFS server"
logger -t backup_josh -s "env: ${SSH_AUTH_SOCK}"
ssh josh@nfs.home.jbeard.dev date || (
  logger -t backup_josh -s "SSH connection to NFS server failed";
  [ "$XDG_SESSION_TYPE" == "wayland" ] && notify-send -t 5000 -a Sysbackup -u critical "Sysbackup Could not connect to NFS server.";
  exit 1
)

logger -t backup_josh -s "SSH connection to NFS server successful"

[ "$XDG_SESSION_TYPE" == "wayland" ] && notify-send -t 2500 -a Sysbackup -u normal "Starting backup of home."

# Local directory in home to backup assorted things outside our home that
# we might own (crontab)
[ ! -d "${HOME}/.backups" ] && mkdir "${HOME}/.backups"

logger -t backup_josh -s "Backing up crontab to ${HOME}/.backups/crontab"
crontab -l >| "${HOME}/.backups/crontab"

if which pacman 2>&1 > /dev/null; then
  logger -t backup_josh -s "Backing up pacman list to ${HOME}/.backups/pacman-list.txt"
  pacman -Q >| "${HOME}/.backups/pacman-list.txt"
fi

logger -t backup_josh -s "Starting sysbackup with config ${CONFIG}"
# Run sysbackup with config
${SYSBACKUP} --config ${CONFIG} 2>&1 | logger -t backup_josh -s

[ "$XDG_SESSION_TYPE" == "wayland" ] && notify-send -t 2500 -a Sysbackup -u normal "Backup complete."

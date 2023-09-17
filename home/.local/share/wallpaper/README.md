# Josh's Wallpaper Scripts

This contains scripts for managing desktop wallpapers. They're currently
specific to my Linux desktop and depend on:

* [Hyprland](https://hyprland.org/) desktop environment (`hyprctl` command is
  used to query monitors).
* [swww](https://github.com/Horus645/swww) for setting wallpapers on Wayland.
* [gosimac](https://github.com/1995parham/gosimac) for downloading wallpapers
  from Bing and Usplash (via cron with [`bin/wall-get.sh`](bin/wall-get.sh)).

## Description

* [`bin/wall-get.sh`](bin/wall-get.sh) retrieves wallpapers using `gosimac` from Bing and
  Usplash. I set this on a crontab schedule.
* [`bin/wall-randomize.sh`](bin/wall-randomize.sh) sets a random wallpaper on
  each monitor detected by Hyprland. I start this when starting Hyprland and it
  runs in a loop.
* [`bin/wall-blacklist.sh`](bin/wall-blacklist.sh) is used for "blacklisting" a wallpaper.
  Since I'm downloading them in bulk, there's often some photos that I don't
  like. This script is a quick way to prevent them from showing up again,
  deleting them, and changing the specified display's wallpaper.
* Sourcing a common config from [`etc/wallpaper.cfg`](etc/wallpaper.cfg)

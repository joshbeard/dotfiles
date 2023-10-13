# Josh's Wallpaper Scripts

Scripts for managing desktop wallpapers.

They're currently specific to my Linux desktop and depend on:

* [gosimac](https://github.com/1995parham/gosimac) for downloading wallpapers
  from Bing and Usplash (via cron with [`bin/wall-get.sh`](bin/wall-get.sh)).
* on xorg: xrandr and nitrogen
* on wayland: hyprland and [swww](https://github.com/Horus645/swww)

## Features

* Download wallpapers from Bing and Unsplash
* Randomly set a wallpaper per display
* Set wallpapers on demand
* Add wallpapers to a list and set from a list
* Track recent wallpapers and avoid setting them for a while
* Blacklist wallpapers
* Supports Xorg and Wayland

## Usage

### Setting Wallpaper

Randomize wallpapers across all detected displays:

```shell
walls.sh set
```
Set a random wallpaper on all displays and exit:

```shell
walls.sh set --once
```

Set a wallpaper on display 2 and exit:

```shell
walls.sh set -d 2 --once
```

### Using Lists

Save the current wallpaper on display 1 to a list called "nature":

```shell
walls.sh add 1 nature
```

Set a wallpaper from a list:

```shell
walls.sh set -d 2 --once --list nature
```

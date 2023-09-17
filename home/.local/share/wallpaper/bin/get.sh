#!/usr/bin/env bash
source "$HOME/.local/share/wallpaper/etc/walls.cfg"
source "$HOME/.local/share/wallpaper/lib/common.sh"

check_required_command md5sum gosimac

gosimac bing
gosimac unsplash

# Compare each file in src_path to the entries in blacklist.txt, formatted as
# md5sum::path. If the md5sum of the file matches the md5sum in blacklist.txt,
# then the file is removed from src_path.
for file in $src_path/*; do
    md5=$(md5sum $file | awk '{print $1}')
    if grep -q $md5 "$blacklist_file"; then
        echo "File $file is blacklisted. Removing..."
        rm $file
    fi
done

# Move all files in src_path to dst_path.
mv "${src_path}"/* "${wallpaper_dir}"

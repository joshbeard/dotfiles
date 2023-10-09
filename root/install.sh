#!/bin/sh
SOURCE="$(pwd)/"
TARGET="/"

sudo rsync -rlptv \
    --exclude=install.sh \
    --exclude=README.md \
    $SOURCE $TARGET

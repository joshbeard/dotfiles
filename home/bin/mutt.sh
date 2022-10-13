#!/bin/sh
# Helper for opening mutt in a terminal or raising the window if it's already
# running.
# One use case is launching mutt via the xfce4 mail checker panel item.
#
# Dependencies: xfce4-terminal, wmctrl

WINDOW_NAME="mutt"

if wmctrl -l | grep "${WINDOW_NAME}" 2>&1 >/dev/null; then
  wmctrl -R "${WINDOW_NAME}"
else
  xfce4-terminal -T "${WINDOW_NAME}" --geometry 135x40 -x mutt
fi


#!/bin/sh
# Helper for opening mutt in a terminal or raising the window if it's already
# running.
# One use case is launching mutt via the xfce4 mail checker panel item.
#
# Dependencies: xfce4-terminal, wmctrl

WINDOW_NAME="mutt"
TERMINAL=xfce4-terminal

mutt_init() {
  winid=$(wmctrl -l -x | grep "${TERMINAL}" | grep "${WINDOW_NAME}" | cut -d' ' -f1)

  if [ "x${winid}" != "x" ]; then
    wmctrl -i -R "${winid}"
  else
    xfce4-terminal -T "${WINDOW_NAME}" --geometry 135x40 -x ${HOME}/bin/mutt.sh run
  fi
}

mutt_run() {
  set -a
  source ~/.env
  mutt
}

if [ "$1" == "run" ]; then
  mutt_run
else
  mutt_init
fi

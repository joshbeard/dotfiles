#!/bin/sh
# Helper for opening mutt in a terminal or raising the window if it's already
# running.

WINDOW_NAME="mutt"
TERMINAL=kitty
COMMAND="kitty --name ${WINDOW_NAME} -T ${WINDOW_NAME} mutt"

mutt_is_running() {
    if [ "$XDG_SESSION_TYPE" == "x11" ]; then
        winid=$(wmctrl -l -x | grep "${TERMINAL}" | grep "${WINDOW_NAME}" | cut -d' ' -f1)
        if [ "x${winid}" == "x" ]; then
            return 1
        else
            return 0
        fi
    elif [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
        existing_window=$(hyprctl clients -j | jq -r ".[] | select(.initialTitle == \"${WINDOW_NAME}\" and .initialClass == \"${TERMINAL}\")")
        if [ "x${existing_window}" == "x" ]; then
            return 1
        else
            return 0
        fi
    fi
}

mutt_focus() {
    if [ "$XDG_SESSION_TYPE" == "x11" ]; then
        winid=$(wmctrl -l -x | grep "${TERMINAL}" | grep "${WINDOW_NAME}" | cut -d' ' -f1)
        #Raise the window in X11:
        wmctrl -i -a "${winid}"
    elif [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
        existing_window=$(hyprctl clients -j | jq -r ".[] | select(.initialTitle == \"${WINDOW_NAME}\" and .initialClass == \"${TERMINAL}\")")
        window_id=$(echo "${existing_window}" | jq -r ".address")
        hyprctl dispatch focuswindow "address:${window_id}"
    fi
}

if mutt_is_running; then
    echo "mutt is running" > $HOME/mutt.log
    mutt_focus
else
    echo "mutt is not running" > $HOME/mutt.log
    set -a
    source ~/.env
    eval "${COMMAND}"
    mutt_focus
fi

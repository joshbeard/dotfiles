#!/bin/sh
# Helper for opening mutt in a terminal or raising the window if it's already
# running. Mutt is launched in a tmux session.

MUTT_EXEC="neomutt"
TERMINAL=alacritty

WINDOW_NAME=$MUTT_EXEC
WINDOW_CLASS=$MUTT_EXEC
TERMINAL_CMD="${TERMINAL} --title ${WINDOW_NAME} --class ${WINDOW_NAME}"

mutt_is_running() {
    if [ "$XDG_SESSION_TYPE" == "x11" ]; then
        winid=$(wmctrl -l -x | grep "${TERMINAL}" | grep "${WINDOW_NAME}" | cut -d' ' -f1)
        if [ "x${winid}" == "x" ]; then
            return 1
        else
            return 0
        fi
    elif [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
        existing_window=$(hyprctl clients -j | jq -r ".[] | select(.initialTitle == \"${WINDOW_NAME}\" and .initialClass == \"${WINDOW_CLASS}\")")
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
        existing_window=$(hyprctl clients -j | jq -r ".[] | select(.initialTitle == \"${WINDOW_NAME}\" and .initialClass == \"${WINDOW_CLASS}\")")
        window_id=$(echo "${existing_window}" | jq -r ".address")
        hyprctl dispatch focuswindow "address:${window_id}"
    fi
}

tmux_attach() {
    tmux has-session -t $MUTT_EXEC 2>/dev/null || tmux new-session -d -s $MUTT_EXEC "$MUTT_EXEC"; tmux attach -t $MUTT_EXEC
}

if [ "$1" = "attach" ]; then
    tmux_attach
    exit 0
fi

if mutt_is_running; then
    mutt_focus
else
    set -a
    source ~/.env
    eval "${TERMINAL_CMD} -e $0 attach"
fi

#!/usr/bin/env bash
# Taken from ThePrimeagen's dotfiles
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    projects=$(find ~/Projects ~/go/src/github.com \
      -mindepth 1 -maxdepth 3 -type d -not -path '*/\.*')
    # Append home to the selected path
    home=$(find ~/ -mindepth 1 -maxdepth 1 -type d -not -path '*/\.*')
    dotfiles=$HOME/.homesick/repos/dotfiles
    selected=$(echo -e "$projects\n$home\n$dotfiles" | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t $selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [ -z "$TMUX" ]; then
    tmux attach-session -t $selected_name
    exit 0
fi

tmux switch-client -t $selected_name

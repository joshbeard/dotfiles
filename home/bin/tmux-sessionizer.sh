#!/usr/bin/env bash
# Adapted from ThePrimeagen's dotfiles
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

if [[ -z "$TERMINAL" ]]; then
  case $(uname) in
    Darwin)
      export TERMINAL=kitty
      ;;
    Linux)
      export TERMINAL=alacritty
      ;;
    *)
      export TERMINAL=alacritty
      ;;
  esac
fi

is_rofi=false
if [[ "$1" == "rofi" ]]; then
  is_rofi=true
fi

# Function to get a list of directories to choose from
get_projects() {
    go_src=$(find ~/go/src -mindepth 1 -maxdepth 3 -type d)
    projects=$(find ~/Projects -mindepth 1 -maxdepth 3 -type d -not -path '*/\.*')
    home=$(find ~/ -mindepth 1 -maxdepth 1 -type d -not -path '*/\.*')
    configs=$(find ~/.config -mindepth 1 -maxdepth 2 -type d)

    paths=(
      "$projects"
      "$go_src"
      "$home"
      "$configs"
      "$HOME/.homesick/repos/dotfiles"
    )
    printf "%s\n" "${paths[@]}"
}

# Function to use rofi to display a menu of directories to select from
rofi_menu() {
  local paths=$1
  local selected

  selected=$(echo -e "$paths" | rofi -dmenu -i \
    -theme ~/.config/rofi/dracula2.rasi \
    -p "Select a directory")
  echo "$selected"
}

# Function to open the tmux session
open() {
  if [[ "$is_rofi" != true ]]; then
    "$@"
    return
  fi

  #alacritty -e "$@"
  #kitty -e "$@"

  $TERMINAL -e "$@"
}

open_in_terminal() {
  $TERMINAL -e tmux-sessionizer.sh $1
}

# Main logic
if [[ $1 == "open" ]]; then
  open_in_terminal "$2"
  exit 0
fi

if [[ $# -eq 1 ]] && [[ "$1" != "rofi" ]]; then
  selected=$1
else
  paths=$(get_projects)

  if [[ "$is_rofi" == true ]]; then
    selected=$(rofi_menu "$paths")
  else
    selected=$(echo -e "$paths" | fzf)
  fi
fi

# Exit if no directory was selected
if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    open tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t $selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [ -z "$TMUX" ]; then
    open tmux attach-session -t $selected_name
    exit 0
fi

open tmux switch-client -t $selected_name

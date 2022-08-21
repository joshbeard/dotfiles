if [ -f /usr/bin/zsh ]; then
  export SHELL=/usr/bin/zsh
elif [ -f /usr/local/bin/zsh ]; then
  export SHELL=/usr/local/bin/zsh
fi

[ -z "$ZSH_VERSION" ] && exec $SHELL -l


# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin

[ -f ~/.env ] && source ~/.env

## rbenv
eval "$(rbenv init -)"

autoload -U compinit; compinit

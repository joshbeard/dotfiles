# My local .zshrc
[ -f ~/.zprezto/runcoms/zshrc ] && source ~/.zprezto/runcoms/zshrc

bindkey '^ ' autosuggest-accept

# tmux
if (( $+commands[tmux] )); then
  alias tmux='tmux -2'
  alias tl='tmux ls'
  alias ta='tmux attach -t'
  alias tr='tmux rename-session -t'
fi

if (( $+commands[bundle] )); then
  alias bi='bundle install'
  alias be='bundle exec'
  alias bl='bundle list'
  # Disable autocorrection for 'bundle'
  alias bundle='nocorrect bundle'
fi

# Easily delete removed files from git index
# From: https://github.com/ariejan/
grm() {
  git status | grep "deleted:" | awk '{print $3}' | xargs git rm --ignore-unmatch
}

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

[ -f $HOME/.env ] && source $HOME/.env
[ -f $HOME/.env.private ] && source $HOME/.env.private

[ -d $HOME/.rbenv/ ]  && eval "$(rbenv init - zsh)"
fpath=(/usr/local/share/zsh-completions $fpath)


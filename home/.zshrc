# ===================================================================
# Josh's .zshrc
#
# Common environment configuration is in .env
#
# Ordering of files:
#   /etc/zsh/zshenv
#   ${HOME}/.zshenv
#   /etc/zsh/zprofile (login shells)
#   ${HOME}/.zprofile (login shells)
#   /etc/zsh/zshrc (interactive shells)
#   ${HOME}/.zshrc (interactive shells) -> zprezto
#   /etc/zsh/zlogin (login shells)
#   ${HOME}/.zlogin (login shells)
#
# On logout:
#   ${HOME}/.zlogout
#   /etc/zsh/zlogout
# ===================================================================
# Load zprezto
[ -f ~/.zprezto/runcoms/zshrc ] && source ~/.zprezto/runcoms/zshrc

bindkey '^ ' autosuggest-accept

# Completions
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

if which saml2aws >>/dev/null 2>&1; then
  eval "$(saml2aws --completion-script-zsh)"
fi

# Common environment configuration
[ -f $HOME/.env ] && source $HOME/.env
[ -f $HOME/.env.private ] && source $HOME/.env.private

eval "$(fasd --init auto)"

# Deal with "dumb" terminals and ttys
#if [[ "$XDG_SESSION_TYPE" == 'tty' ]]; then
#  prompt josh
#fi
if [[ "$TERM" == 'linux' ]]; then
  #zstyle ':prezto:module:prompt' theme 'josh'
  prompt josh
fi

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}


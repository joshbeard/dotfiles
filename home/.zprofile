# .zprofile
#
# Commands are then read from $ZDOTDIR/.zshenv.  If the shell is a  login
# shell, commands  are read  from  /etc/zsh/zprofile and then
# $ZDOTDIR/.zprofile.  Then, if the shell is interactive, commands are read from
# /etc/zsh/zshrc and then $ZDOTDIR/.zshrc.  Finally, if the  shell  is  a login
# shell, /etc/zsh/zlogin and $ZDOTDIR/.zlogin are read.
#
# Ordering of files:
#   /etc/zsh/zshenv
#   ${HOME}/.zshenv
#   /etc/zsh/zprofile (login shells)
#   ${HOME}/.zprofile (login shells)
#   /etc/zsh/zshrc (interactive shells)
#   ${HOME}/.zshrc (interactive shells)
#   /etc/zsh/zlogin (login shells)
#   ${HOME}/.zlogin (login shells)
#
# On logout:
#   ${HOME}/.zlogout
#   /etc/zsh/zlogout



# .zlogout

# When  a  login  shell  exits,  the files $ZDOTDIR/.zlogout and then
# /etc/zsh/zlogout are read.  This happens with either an explicit exit via the
# exit or logout commands, or an implicit exit by  reading  end-of-file  from
# the terminal.  However, if the shell terminates due to exec'ing another
# process, the logout files are not read.  These  are  also  affected  by  the
# RCS  and GLOBAL_RCS  options.   Note also that the RCS option affects the
# saving of history files, i.e.  if RCS is unset when the shell exits, no
# history file will be saved.
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


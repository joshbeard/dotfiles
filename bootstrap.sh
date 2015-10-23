#!/bin/sh
## Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

## Use homesick to fetch dotfiles
gem install homesick
homesick clone joshbeard/dotfiles
homesick link dotfiles

## Install vundle for vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

vim +PluginInstall +qall

#!/bin/sh
## Install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

## Use homesick to fetch dotfiles
gem install homesick
homesick clone joshbeard/dotfiles
homesick symlink joshbeard/dotfiles

## Install vundle for vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

## Use vundle to install vim plugins/extensions
#run `:BundleInstall` from within vim
vim -c ":BundleInstall"

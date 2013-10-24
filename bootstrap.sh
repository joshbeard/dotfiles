#!/bin/sh


## Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

## Use homesick to fetch dotfiles
gem install homesick
homesick clone joshbeard/dotfiles
homesick symlink joshbeard/dotfiles

## Install vundle for vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

## Use vundle to install vim plugins/extensions
#run `:BundleInstall` from within vim
vim -c ":BundleInstall"

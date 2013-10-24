I'll put some of my dotfiles here - mostly for my own portability.

## Install oh-my-zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

## Use homesick to fetch dotfiles
    gem install homesick
    homesick clone joshbeard/dotfiles
    homesick symlink joshbeard/dotfiles

## Install vundle for vim
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

## Use vundle to install vim plugins/extensions
run `:BundleInstall` from within vim
You can also just do:
    vim -c ":BundleInstall"

## Updating
   homesick pull

And also useful is
   homesick symlink

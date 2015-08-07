I'll put some of my dotfiles here - mostly for my own portability.

## Install oh-my-zsh

```shell
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
```

## Use homesick to fetch dotfiles

```shell
gem install homesick
homesick clone joshbeard/dotfiles
homesick symlink dotfiles
```

## Install vundle for vim

```shell
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Install plugins

```shell
vim +PluginInstall +qall
```

## Updating

```shell
homesick pull
```

And also useful is

```shell
homesick symlink
```

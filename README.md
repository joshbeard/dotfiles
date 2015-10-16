## Install [prezto](https://github.com/sorin-ionescu/prezto)

```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
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

## Other things

[homebrew-notifier](https://github.com/grantovich/homebrew-notifier)



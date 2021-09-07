# Josh's Dotfiles

I use the [homesick](https://rubygems.org/gems/homesick) Ruby Gem to maintain
my dotfiles. I use [zsh](https://www.zsh.org/) on my workstation with
[prezto](https://github.com/sorin-ionescu/prezto).

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

## Install Dependencies

```shell
brew install reattach-to-user-namespace
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

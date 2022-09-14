# Josh's Dotfiles

I'm using [homeshick](https://github.com/andsens/homeshick) to maintain
my dotfiles. I use [zsh](https://www.zsh.org/) on my workstations with
[prezto](https://github.com/sorin-ionescu/prezto). I also use bash.

These dotfiles are intended to be usable across my environments consisting of MacOS, Linux, and BSD.

## Install [prezto](https://github.com/sorin-ionescu/prezto)

```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

## Install homeshick or homesick

I now prefer [homeshick](https://github.com/andsens/homeshick) for
its lighter dependency list. The repository works with _homeshick_ or _homesick_.

__Install homeshick__ (requires bash):

```shell
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone joshbeard/dotfiles
```

Refer to the [homeshick installation guide](https://github.com/andsens/homeshick/wiki/Installation) for more information.

__Deprecated: Install homesick__ (requires Ruby):

Installing the Ruby _homesick_ gem isn't necessary if _homeshick_ is used.

```shell
gem install homesick
homesick clone joshbeard/dotfiles
homesick symlink dotfiles
```

### Install Dependencies

On a Mac with _homebrew_:

```shell
brew install reattach-to-user-namespace
```

## Vim

### Install vundle for Vim

```shell
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### Install Vim plugins

```shell
vim +PluginInstall +qall
```

## Updating

### Updating with homeshick

```shell
homeshick refresh
```

### Updating with homesick

```shell
homesick pull
```

And also useful is

```shell
homesick symlink
```

## Other things

[homebrew-notifier](https://github.com/grantovich/homebrew-notifier)

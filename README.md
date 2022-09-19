# Josh's Dotfiles

I'm using [homeshick](https://github.com/andsens/homeshick) to maintain
my dotfiles. I use [zsh](https://www.zsh.org/) on my workstations with
[prezto](https://github.com/sorin-ionescu/prezto). I also use bash.

These dotfiles are intended to be usable across my environments consisting of macOS, Linux, and BSD.

## Install homeshick

I now prefer [homeshick](https://github.com/andsens/homeshick) for
its lighter dependency list. The repository works with _homeshick_ or _homesick_ (Rubygem).

```shell
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone joshbeard/dotfiles
```

Refer to the [homeshick installation guide](https://github.com/andsens/homeshick/wiki/Installation) for more information.


## Install [prezto](https://github.com/sorin-ionescu/prezto) for ZSH

This isn't required. I mostly use zsh with prezto day-to-day on my workstations, but my dotfiles repo contains functional configs even without prezto
for zsh.

```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
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

```shell
homeshick pull
homeshick refresh
homeshick symlink
```

## Other things

* Git GPG signing is enabled by default. Disable it in [`home/.gitconfig.personal`](home/.gitconfig.personal), if necessary.
* [homebrew-notifier](https://github.com/grantovich/homebrew-notifier): notifications on Mac for homebrew updates


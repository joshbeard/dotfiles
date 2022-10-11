# Josh's Dotfiles

I'm using [homeshick](https://github.com/andsens/homeshick) to maintain
my dotfiles. I use [zsh](https://www.zsh.org/) on my workstations with
[prezto](https://github.com/sorin-ionescu/prezto). I also use bash.

These dotfiles are intended to be usable across my environments consisting of
macOS, Linux, and BSD.

## Install [prezto](https://github.com/sorin-ionescu/prezto) for ZSH

This isn't required. I mostly use zsh with prezto day-to-day on my workstations,
but my dotfiles repo contains functional configs even without prezto for zsh.

```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

## Install homeshick

I am using [homeshick](https://github.com/andsens/homeshick) to maintain my
dotfiles in Git and the synchronization across systems.

```shell
# Clone homeshick
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
# Clone dotfiles with homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone joshbeard/dotfiles
```

Refer to the [homeshick installation
guide](https://github.com/andsens/homeshick/wiki/Installation) for more
information.

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

* Git GPG signing is enabled by default. Disable it in
  [`home/.gitconfig`](home/.gitconfig), if necessary.
* [homebrew-notifier](https://github.com/grantovich/homebrew-notifier):
  notifications on Mac for homebrew updates


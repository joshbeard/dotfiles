# Josh's Dotfiles

These dotfiles are intended to be usable across my environments consisting of
Linux, macOS, and BSD on personal and corporate devices.

I use [homeshick](https://github.com/andsens/homeshick) to maintain
my dotfiles on my workstations. I primarily use [zsh](https://www.zsh.org/)
with [prezto](https://github.com/sorin-ionescu/prezto).

## Setup

### 1. Install [prezto](https://github.com/sorin-ionescu/prezto) for ZSH

```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

### 2. Install homeshick

```shell
# Clone homeshick
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
# Clone dotfiles with homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone joshbeard/dotfiles
homeshick link
```

Refer to the [homeshick installation
guide](https://github.com/andsens/homeshick/wiki/Installation) for more
information.

### 3. Install NeoVim and Vim plugins

NOTE: I have `vim` aliased to `nvim` if it's installed.

#### 3.1 Install NeoVim Plugins

```shell
:Lazy sync
```

#### 3.2 Install vundle for Vim

```shell
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

##### 3.2.1 Install Vim plugins

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

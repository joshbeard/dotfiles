# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
if [ -f ~/.oh-my-zsh/custom/themes/josh.zsh-theme ]; then
  ZSH_THEME="josh"
else
  ZSH_THEME="robbyrussell"
fi

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github tmux rvm ruby osx macports vagrant zsh-syntax-highlighting ssh-agent autojump)

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  }


export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:~/bin

source $ZSH/oh-my-zsh.sh

# vi mode
# set -o vi
# bindkey '^?' backward-delete-char

# aliases
alias v=/usr/bin/vagrant
alias marked='open -a marked'
alias tmux='tmux -2'
alias less='less -X'

export MANPAGER="less -X"
export PAGER="less -X"
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# for envpuppet (https://github.com/puppetlabs/puppet/blob/master/ext/envpuppet)
export ENVPUPPET_BASEDIR=/Users/josh/Projects/envpuppet
alias puppet='sh ~/bin/envpuppet puppet'
alias facter='sh ~/bin/envpuppet facter'

alias puppet-lint='puppet-lint --no-80chars-check --no-documentation-check'

autoload -U compinit; compinit

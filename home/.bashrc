# ===================================================================
# Josh's .bashrc
#
# Common environment configuration is in .env
# ===================================================================

if [[ $- != *i* ]] ; then
         # Shell is non-interactive.  Be done now!
         return
fi

#enable bash completion
[ -f /etc/profile.d/bash-completion ] && source /etc/profile.d/bash-completion

[ -f "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash" ] && \
  source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

[ -d $HOME/.rbenv/ ]  && eval "$(rbenv init - zsh)"

# Common environment configuration (sh, bash, zsh)
[ -f $HOME/.env ] && source $HOME/.env
[ -f $HOME/.env.private ] && source $HOME/.env.private
[ -f $HOME/.env.local ] && source $HOME/.env.local

if [ ! -z "$NVM_DIR" ]; then
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

parse_git_branch() {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

complete -cf sudo       # Tab complete for sudo

## shopt options
shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite
shopt -s checkwinsize   # Check window after each command
shopt -s dotglob        # files beginning with . to be returned in the results of path-name expansion.

## set options
set -o noclobber        # prevent overwriting files with cat
set -o ignoreeof        # stops ctrl+d from logging me out

# Make bash check its window size after a process completes

##############################################################################
# Color variables
##############################################################################
txtblk="\[\033[0;30m\]" # Black - Regular
txtred="\[\033[0;31m\]" # Red
txtgrn="\[\033[0;32m\]" # Green
txtylw="\[\033[0;33m\]" # Yellow
txtblu="\[\033[0;34m\]" # Blue
txtpur="\[\033[0;35m\]" # Purple
txtcyn="\[\033[0;36m\]" # Cyan
txtwht="\[\033[0;37m\]" # White
bldblk="\[\033[1;30m\]" # Black - Bold
bldred="\[\033[1;31m\]" # Red
bldgrn="\[\033[1;32m\]" # Green
bldylw="\[\033[1;33m\]" # Yellow
bldblu="\[\033[1;34m\]" # Blue
bldpur="\[\033[1;35m\]" # Purple
bldcyn="\[\033[1;36m\]" # Cyan
bldwht="\[\033[1;37m\]" # White
unkblk="\[\033[4;30m\]" # Black - Underline
undred="\[\033[4;31m\]" # Red
undgrn="\[\033[4;32m\]" # Green
undylw="\[\033[4;33m\]" # Yellow
undblu="\[\033[4;34m\]" # Blue
undpur="\[\033[4;35m\]" # Purple
undcyn="\[\033[4;36m\]" # Cyan
undwht="\[\033[4;37m\]" # White
bakblk="\[\033[40m\]"   # Black - Background
bakred="\[\033[41m\]"   # Red
bakgrn="\[\033[42m\]"   # Green
bakylw="\[\033[43m\]"   # Yellow
bakblu="\[\033[44m\]"   # Blue
bakpur="\[\033[45m\]"   # Purple
bakcyn="\[\033[46m\]"   # Cyan
bakwht="\[\033[47m\]"   # White
txtrst="\[\033[0m\]"    # Text Reset
# Reset
ColorOff="\[\033[0m\]"       # Text Reset
##############################################################################

if [ $(id -u) -eq 0 ];
        then # you are root, set red colour prompt
                PS1="${txtylw}\w ${txtred}#${txtrst} "
        else
                #PS1='\h:\W \u\$ '
                PS1="${txtblu}\h${txtwht}:${txtgrn}\w${txtylw}\$(parse_git_branch)${txtblu} \$${txtrst} "
                SUDO_PS1="${txtylw}\w ${txtred}#${txtrst} "
fi

export GREP_OPTIONS=--color=auto
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export CLICOLOR=1

##############################################################################
# Functions
##############################################################################
# Delete line from known_hosts
# courtesy of rpetre from reddit
ssh-del() {
    sed -i -e ${1}d ~/.ssh/known_hosts
}

psgrep() {
        if [ ! -z $1 ] ; then
                echo "Grepping for processes matching $1..."
                ps aux | grep $1 | grep -v grep
        else

                echo "!! Need name to grep for"
        fi
}

# clock - a little clock that appeares in the terminal window.
# Usage: clock.
#
clock ()
{
while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}

# showip - show the current IP address if connected to the internet.
# Usage: showip.
#
showip ()
{
lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' 
}

##################
#extract files eg: ex tarball.tar#
##################
ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       rar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


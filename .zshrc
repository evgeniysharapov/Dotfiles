#
#  ZSH configuration
#
#  This  configuration is  shared among multiple machines, so I try to accomodate all of their specifics
# 
#  Author: Evgeniy Sharapov
#

# avoid "no match" message 
setopt no_nomatch

## Figure out what OS/Host we are on
Z_OS=$(( cat /etc/*-release 2>/dev/null | sed -n 's/^ID=\(.*\)/\1/p' ))

if [ -z $Z_OS ]; then
    # could be MacOSX or Windows
    if [[ "$OSTYPE" == darwin* ]]; then
        Z_OS=osx
    else
        Z_OS=win
    fi
fi

# short name -s option is not always supported
Z_HOST=${$(hostname)//.*/}

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# override customization for OMZ
ZSH_CUSTOM="${HOME}/.zsh_custom"
# loading our theme
ZSH_THEME="eshar"
#ZSH_THEME="kphoen"
# we don't want to auto-update
DISABLE_AUTO_UPDATE="true"
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"
# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"
# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"
# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=()

##  $+commands[] checks if command is available
if (( $+commands[git] )) ; then
    plugins+=(git git-extras)
    # add git extras scripts to the path
    path+=$HOME/.git-extras/bin
fi

if (( $+commands[hg] )); then
    plugins+=mercurial
fi

if (( $+commands[ruby] )); then
    plugins+=(bundler rvm)
fi

## Various System Specific Configurations
[[ -f "${HOME}/.zshrc.${Z_OS}" ]] && source "${HOME}/.zshrc.${Z_OS}"
[[ -f "${HOME}/.zshrc.${Z_HOST}" ]] && source "${HOME}/.zshrc.${Z_HOST}"
    
# Customize to your needs...
export LESS=' -R '

## Loading OMZ
source $ZSH/oh-my-zsh.sh

# More history 
HISTSIZE=100000
SAVEHIST=$HISTSIZE
# avoid duplicates
# https://wiki.archlinux.org/index.php/zsh#Preventing_duplicate_lines_in_the_history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# opam configuration
test -r /c/Users/esharapov/.opam/opam-init/init.zsh && . /c/Users/esharapov/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

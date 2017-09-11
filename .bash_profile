
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PATH=/usr/local/bin:$PATH
export PS1='\u@\h \w $'

black='\['`tput sgr0; tput setaf 0`'\]'
red='\['`tput sgr0; tput setaf 1`'\]'
green='\['`tput sgr0; tput setaf 2`'\]'
yellow='\['`tput sgr0; tput setaf 3`'\]'
blue='\['`tput sgr0; tput setaf 4`'\]'
magenta='\['`tput sgr0; tput setaf 5`'\]'
cyan='\['`tput sgr0; tput setaf 6`'\]'
white='\['`tput sgr0; tput setaf 7`'\]'

BLACK='\['`tput setaf 0; tput bold`'\]'
RED='\['`tput setaf 1; tput bold`'\]'
GREEN='\['`tput setaf 2; tput bold`'\]'
YELLOW='\['`tput setaf 3; tput bold`'\]'
BLUE='\['`tput setaf 4; tput bold`'\]'
MAGENTA='\['`tput setaf 5; tput bold`'\]'
CYAN='\['`tput setaf 6; tput bold`'\]'
WHITE='\['`tput setaf 7; tput bold`'\]'

PLAIN='\['`tput sgr0`'\]'

GREEN="\[\e[0;32m\]"
BLUE="\[\e[1;34m\]"
RED="\[\e[1;31m\]"
PLAIN="\[\e[m\]"

#export PS1="${GREEN}\u@\h ${BLUE}\W $ ${PLAIN}"

# Git settings 
git_branch(){
    git branch &>/dev/null; 
    if [ $? -eq 0 ]; then
        echo -e "($(git branch | grep ^* | sed s/\*\ //))"; 
    fi
}

export GIT_EDITOR="emacs"
# show Git branch in the prompt 
export PS1="${GREEN}\u@\h${BLUE} \w ${RED}\$(git_branch)${BLUE}\$${PLAIN} "

alias gitk="/usr/bin/wish $(which gitk)"

# macports setup
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# install Ant Bash completion
#if [ -f /opt/local/etc/bash_completion ]; then
#	. /opt/local/etc/bash_completion
#fi

#complete -C /opt/local/share/java/apache-ant/bin/complete-ant-cmd.pl ant

# set up maven 

# this function show man documentation in Preview.app
pman()
{
	man -t "${1}" | open -f -a /Applications/Preview.app/
}

#
#  Add Emacs.app to the PATH environment
#
export PATH=/Applications/Emacs.app/Contents/MacOS:/Applications/Emacs.app/Contents/MacOS/bin:$PATH
alias emacs='emacs -nw '

#
#  Add Cabal into the path 
#
export PATH=~/.cabal/bin:$PATH

#
#  Adding ~/bin to the PATH
#
export PATH=~/bin:$PATH
#
# Tweak bash history
#
export HISTSIZE=1000
export HISTCONTROL=erasedups
shopt -s histappend


##
# Your previous /Users/evgeniysharapov/.bash_profile file was backed up as /Users/evgeniysharapov/.bash_profile.macports-saved_2012-05-28_at_22:31:50
##

# MacPorts Installer addition on 2012-05-28_at_22:31:50: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

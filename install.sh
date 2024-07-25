#!/bin/zsh

#
# Deploys our configuration files in HOME directory as symbolic links
# This expects stow to be available
#

all_modules=(
    ack
#    autohotkey
    bash
    ctags
    eslint
    gem
    ghc
    git
    global
    hammerspoon
#    hg
    input
    kdiff
#    macos
    npm
#    octave
    scripts
    tmux
    vim
    zsh
)
for mod_name in $all_modules;
do
    stow $mod_name
done



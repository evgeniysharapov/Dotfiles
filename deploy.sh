#!/bin/sh

# 
# Deploys our configuration files in HOME directory as symbolic links
# you can always pass file names of files you don't want symbolic links created for

self="$0"

# we can pass a parameter - filename, that need not to be linked to
custom_skip=$(echo "$*" | sed 's/ /\\|/g; s/\./\\./g')
if [ -n "$custom_skip" ]; then
    custom_skip="$custom_skip\|"
fi

# some files don't need to be linked to
skip="${self#./}\|${custom_skip}README\|\.\(hg\|hgsub\|hgsubstate\|hgignore\|\.\)\?$"
echo "$skip"
for file in $(ls -a | grep -v "$skip")
do
    ln -sn $(pwd)/$file $HOME/$file
done

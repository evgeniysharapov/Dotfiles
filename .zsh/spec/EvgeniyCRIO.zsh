#
# Configuration Specific to CRIO Macbook Pro
# 
# check for homebrew and evaluate its shell setup 
eval "$(/opt/homebrew/bin/brew shellenv)"

setopt auto_cd
cdpath=($HOME/Documents/EDC $HOME/Documents $HOME/Documents/Looker)

# gcloud settings
source $HOME/google-cloud-sdk/completion.zsh.inc
source $HOME/google-cloud-sdk/path.zsh.inc



#
# Configuration Specific to CRIO Macbook Pro
# 

setopt auto_cd
cdpath=($HOME/Documents/EDC $HOME/Documents $HOME/Documents/Looker)

# gcloud settings
source $HOME/google-cloud-sdk/completion.zsh.inc
source $HOME/google-cloud-sdk/path.zsh.inc

# kubectl completions
source <(kubectl completion zsh)

# For Google Cloud SDK development 
export GOOGLE_APPLICATION_CREDENTIALS=/Users/evgeniysharapov/.keys/crio-dev-267118-fb2d927062e3.json


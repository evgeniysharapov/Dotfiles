#
# Configuration Specific to CRIO Macbook Pro
# 

setopt auto_cd
cdpath=($HOME/Projects /mnt/c/Users/sharape /mnt/c/Users/sharape/Documents)

# added Intellij IDEA
export PATH=/opt/idea-IC-233.14015.106/bin:$PATH

# Adding 'sdk' command from SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

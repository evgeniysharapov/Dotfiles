#
# Configuration Specific to CRIO Macbook Pro
# 

setopt auto_cd
cdpath=($HOME/Projects $HOME/Personal /mnt/c/Users/sharape /mnt/c/Users/sharape/Documents)

# pyenv (installed according to https://kfields.me/blog/pyenv_on_ubuntu_22
export PATH="$HOME/.pyenv/bin:$PATH"
which pyenv > /dev/null && \
    eval "$(pyenv init --path)" && eval "$(pyenv virtualenv-init -)"

# Adding nodenv, see https://gist.github.com/mrbar42/faa10a68e32a40c2363aed5e150d68da
which nodenv > /dev/null && \
    eval "$(nodenv init - zsh)"


# added Intellij IDEA
#export PATH=/opt/idea-IC-233.14015.106/bin:$PATH
export PATH=/opt/idea-IU-241.14494.240/bin:$PATH
# let's add an alias for idea and redirect all the noise to dev/null
alias idea='idea NUL &'
# alias to clear logs in `lvs-rest.log`
alias clear-logs-lvs-rest='docker exec -it lvs-docker-dev-lvs-rest-1 sh -c "echo > /opt/labcorp/user-home/logs/lvs-rest.log"'

# Adding 'sdk' command from SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Adding QCad
export PATH=$HOME/opt/qcad-3.29.6-trial-linux-qt5.14-x86_64:$PATH

# Compiled and installed Emacs29 to /opt/emacs29/
export PATH="/opt/emacs29/bin:$PATH"


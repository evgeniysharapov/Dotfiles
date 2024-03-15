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
export PATH=/opt/idea-IC-233.14015.106/bin:$PATH

# Adding 'sdk' command from SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

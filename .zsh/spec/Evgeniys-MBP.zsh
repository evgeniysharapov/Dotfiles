# configuration specific for New Macbook Pro 2018

# make sure we initialize pyenv
which pyenv > /dev/null && \
    eval "$(pyenv init -)"


# configure shell for rbenv
which rbenv > /dev/null && \
    eval "$(rbenv init -)"

# increasing ulimit for file descriptors
ulimit -n 2048

# add docker to the list of plugins
plugins+=(docker docker-compose)

# node development
which nodenv > /dev/null && \
    eval "$(nodenv init -)"

# java development
which jenv > /dev/null && \
    eval "$(jenv init -)"

setopt auto_cd

# useful aliases
alias e="emacsclient"
alias te="emacsclient -t"
alias et="emacsclient -t"
 

# MacOS X Specific Configuration

# make sure we initialize pyenv
which pyenv > /dev/null && \
    eval "$(pyenv init -)"

# configure shell for rbenv
which rbenv > /dev/null && \
    eval "$(rbenv init -)"

# node development
which nodenv > /dev/null && \
    eval "$(nodenv init -)"

# java development
which jenv > /dev/null && \
    eval "$(jenv init -)"


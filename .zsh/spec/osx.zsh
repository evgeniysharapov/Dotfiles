# MacOS X Specific Configuration

# check for homebrew and evaluate its shell setup
eval "$(/opt/homebrew/bin/brew shellenv)"

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

# Homebrew Completions 
fpath=($HOMEBREW_REPOSITORY/share/zsh/site-functions/ $fpath)

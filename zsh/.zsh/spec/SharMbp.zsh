# configuration specific for New Macbook Pro 2018

# increasing ulimit for file descriptors
ulimit -n 2048

# add docker to the list of plugins
plugins+=(docker docker-compose)

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

which opam > /dev/null && \
    eval "$(opam env)"

setopt auto_cd
 
# we have installed Guile
export GUILE_LOAD_PATH="/usr/local/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/usr/local/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/usr/local/lib/guile/3.0/extensions"

# adjust PATH adding HomeBrew path
export PATH=$(brew --prefix)/sbin:$PATH

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
export HOMEBREW_GITHUB_API_TOKEN=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

# Mac OS X TeX environment
export PATH=/Users/evgeniysharapov/.ConTeXt/tex/texmf-osx-64/bin:$PATH

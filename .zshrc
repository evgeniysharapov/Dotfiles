# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kphoen"

# we don't want to auto-update
DISABLE_AUTO_UPDATE="true"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras osx macports bundler rvm cabal)
# add git extras scripts to the path
export PATH=${PATH}:$HOME/.git-extras/bin

# Customize to your needs...
export PATH=$HOME/bin:$HOME/Library/Haskell/bin:/Applications/Emacs.app/Contents/MacOS:/Applications/Emacs.app/Contents/MacOS/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin:/usr/local/texlive/2012/bin/x86_64-darwin:$PATH

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
# otherwise tends to correct ack command
alias ack='nocorrect ack-5.16'
alias git='nocorrect git'
alias e='Emacs -nw'
alias ec='emacsclient -n'
alias ctags=/opt/local/bin/ctags
alias rsd='rails s --debugger'
alias ffmpeg='/opt/local/bin/ffmpeg'

function changes(){
    __changes=`g --no-pager log --format="%n%x09* %s%d" $(g tag | sort -r | head -1)..HEAD`
    echo "$__changes"
}

# using less with pygments
export LESSOPEN="| /opt/local/bin/pygmentize-2.4 -g %s"
export LESS=' -R '

# Go programming language
export GOROOT="/usr/local/go"
export GOPATH="${HOME}/.gocode"
export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

# RVM settings (should be at the very end)
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
source $ZSH/oh-my-zsh.sh

# TeX and ConTeX settings
export PATH=${PATH}:${HOME}/ConTeXt/tex/texmf-osx-64/bin

# Configure Haskell
export PATH=${HOME}/Library/Haskell/bin:${PATH}


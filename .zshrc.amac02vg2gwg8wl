# configuration specific for new Avanade Macbook

# make sure we initialize pyenv
which pyenv > /dev/null && \
    eval "$(pyenv init -)"


# configure shell for rbenv
which rbenv > /dev/null && \
    eval "$(rbenv init -)"

# adding Docker Toolbox default machine
#if [ $(docker-machine status) = "Stopped" ]
#then
#    docker-machine start
#fi
#eval $(docker-machine env)

# increasing ulimit for file descriptors
ulimit -n 2048

# add docker to the list of plugins
plugins+=(docker docker-compose)

# alias docker and docker-machine
alias dk='docker'
alias dkm='docker-machine'

# node development
which nodenv > /dev/null && \
    eval "$(nodenv init -)"

# java development
which jenv > /dev/null && \
    eval "$(jenv init -)"

setopt auto_cd
cdpath=($HOME/Projects $HOME/Projects/Ensemble)

# Run mocha tests
# 
# @param String to use for grepping 
function mozart_mocha () {
    LOG_LEVEL=${LOG_LEVEL:-debug} MONGO_URL=mongodb://localhost:27018/mock-db ./node_modules/.bin/mocha --recursive --reporter spec --compilers js:babel-core/register --grep "$1" test/server
}
# Debug mocha tests
# 
# @param String to use for grepping 
function mozart_mocha_debug () {
    LOG_LEVEL=silly MONGO_URL=mongodb://localhost:27018/mock-db ./node_modules/.bin/mocha --inspect --inspect-brk --recursive --reporter spec --compilers js:babel-core/register --grep "$1" test/server
}

# useful aliases
alias e="emacsclient"
alias te="emacsclient -t"
alias et="emacsclient -t"
alias docker_clean="docker images -f dangling=true -q | xargs docker rmi"
 

# ConTeXt and friends
#source $HOME/.context/tex/setuptex

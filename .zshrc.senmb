#
# Configuration specific to my older Macbook 
#

export PATH=$HOME/bin:$HOME/Library/Haskell/bin:/Applications/Emacs.app/Contents/MacOS:/Applications/Emacs.app/Contents/MacOS/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin:/usr/local/texlive/2012/bin/x86_64-darwin:$PATH

function changes(){
    __changes=`g --no-pager log --format="%n%x09* %s%d" $(g tag | sort -r | head -1)..HEAD`
    echo "$__changes"
}

path+=${HOME}/Library/Haskell/bin

# Ruby configuration (gems from the HOME directory)
if which ruby >/dev/null && which gem >/dev/null; then
	    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# using less with pygments
#export LESSOPEN="| /opt/local/bin/pygmentize-2.4 -g %s"

## Go programming language
export GOROOT="/usr/local/go"
export GOPATH="${HOME}/.gocode"
export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

# RVM settings (should be at the very end)
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


## TeX and ConTeX settings
export PATH=${PATH}:${HOME}/ConTeXt/tex/texmf-osx-64/bin

# Configure Node.JS and NPM paths
export PATH=${PATH}:${HOME}/.local/lib/npm/bin

# Setting up Boot2Docker and Docker client
if [ $Z_OS = "osx" -a 
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/evgeniysharapov/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1


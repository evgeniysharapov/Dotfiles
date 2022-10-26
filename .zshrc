#
#  ZSH configuration
#
#  This  configuration is  shared among multiple machines, so I try to accomodate all of their specifics
# 
#  Author: Evgeniy Sharapov
#


# * Extra Scripts Directory
ZSH=${HOME}/.zsh
# caching 
ZSH_CACHE_DIR=${ZSH}/cache

# load plugins and other stuff
for zsh_file ($ZSH/plugins/*.zsh); do
    source $zsh_file
done

# * Figure OS/Host
# avoid "no match" message 
setopt no_nomatch
Z_OS=$(cat /etc/*-release 2>/dev/null | sed -n 's/^ID=\(.*\)/\1/p')

if [ -z $Z_OS ]; then
    # could be MacOSX or Windows
    if [[ "$OSTYPE" == darwin* ]]; then
        Z_OS=osx
    else
        Z_OS=win
    fi
fi
# on mac the most reliable way is to use 'scutil'
if [[ $Z_OS = "osx" ]]; then
    Z_HOST=$(scutil --get ComputerName)    
else
    # short name -s option is not always supported
    Z_HOST=${$(hostname)//.*/}
fi

# * Options
# recognize comments
setopt interactivecomments
# jobs
setopt long_list_jobs
# correction
setopt correct_all

# directories stack
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# * Editing Command Line
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
export EDITOR="emacsclient -t -a '' "
export VISUAL="$EDITOR"

# * Keybindings

# Use emacs key bindings
bindkey -e

# / is not part of the word. This works with word delete functionality
export WORDCHARS=${WORDCHARS:s/\///}
  
# <Up> will search history back 
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

if [[ -n "${terminfo[kcuu1]}" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# for some reason using $terminfo doesn't work on mac
if [[ "$Z_OS" == "osx" ]]; then
    bindkey '^[[A' up-line-or-beginning-search
fi

# <Down> will search history forward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search    
if [[ -n "${terminfo[kcud1]}" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search    
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
# for some reason using $terminfo doesn't work on mac
if [[ "$Z_OS" == "osx" ]]; then
    bindkey '^[[B' down-line-or-beginning-search
fi


# * History
if [ -z "$HISTFILE" ]; then
    HISTFILE=${ZSH}/history/zsh_history-${Z_HOST}
fi
# More history is saved 
HISTSIZE=100000
SAVEHIST=$HISTSIZE
# avoid duplicates
# https://wiki.archlinux.org/index.php/zsh#Preventing_duplicate_lines_in_the_history
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history

alias history='fc -il 1'

# ignore following command (see http://zsh.sourceforge.net/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell)

# searching history

# This is a global variable that defines how the query should be highlighted
# inside a matching command. Its default value causes this script to
# highlight using bold, white text on a magenta background. See the
# "Character Highlighting" section in the zshzle(1) man page to learn
# about the kinds of values you may assign to this variable.
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND

# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND is a global variable
# that defines how the query should be highlighted when no commands in
# the history match it. Its default value causes this script to
# highlight using bold, white text on a red background. See the
# "Character Highlighting" section in the zshzle(1) man page to learn
# about the kinds of values you may assign to this variable.

# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS is a global variable that
# defines how the command history will be searched for your query. Its
# default value causes this script to perform a case-insensitive
# search. See the "Globbing Flags" section in the zshexpn(1) man page
# to learn about the kinds of values you may assign to this variable.

# HISTORY_SUBSTRING_SEARCH_FUZZY is a global variable that defines how
# the command history will be searched for your query. If set to a
# non-empty value, causes this script to perform a fuzzy search by
# words, matching in given order e.g. ab c will match *ab*c*#
# searching history
HISTORY_SUBSTRING_SEARCH_FUZZY=true




# * Completions
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# case insensitive (all), partial-word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

# use menu
zstyle ':completion:*' menu select

# processes
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Load all stock functions (from $fpath files) called below.
autoload -U compaudit
autoload -U compinit

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${HOME}/.zcompdump-${Z_HOST}-${ZSH_VERSION}"
fi
compinit -i -d "${ZSH_COMPDUMP}"

# ** Npm Run completions
function _npm_scripts () {
     compls=$([[ -s $PWD/package.json ]] || return 0 && cat package.json | tr -d " \t\n\r" | grep -oP 'scripts\"\:\{(.*?)\}' | sed -e "s/scripts\"\://g" | sed -e "s/{//g" | grep -oP '\"(.*?):\"' | sed -e 's/\"//g' | sed -e 's/\:$//g' | sed -e 's/\,//g' | sort)

     completions=(${=compls})
     compadd -- $completions
}
compdef _npm_scripts npm run

# * Prompt

# Perform parameter expansion, command substitution and arithmetic expansion in prompts
setopt prompt_subst

# Using VCS Info for styling left part 
autoload -Uz vcs_info
autoload -U colors && colors
    
zstyle ':vcs_info:*' disable cdv cvs darcs fossil mtn p4 svk tla svn
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' stagedstr '%F{green} +%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow} *%f'
# use-simple reduces hg overhead but doesn't show dirty or local rev numbers
zstyle ':vcs_info:hg*:*' use-simple true

## Styling vcs_info prompt
# %r - repo
# %s - system used (Git or Hg)
# %b - current branch
# %m - misc replacement for Hg
# %u - unstaged changes
# %c - staged changes

theme_precmd () {
    # do we have untracked files in Git repo
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        zstyle ':vcs_info:git*' formats '%F{yellow}%s%f on %F{green}%b%f%u%c '
    else
        # we have some files we are not tracking in git
        zstyle ':vcs_info:git*' formats '%F{yellow}%s%f on %F{green}%b%f%u%c !'
    fi

    # for hg git branch is less important than bookmark
    zstyle ':vcs_info:hg*' formats '%F{yellow}%s%f on %F{green}%m%b%f%u%c '
    # run vcs_magic
    vcs_info
}

prompt_repo_line () {
    # if vcs_info_msg_0_ is empty or only spaces then we use two line prompt
    if [[ -z "${vcs_info_msg_0_// }" ]]; then
        echo ''
    else
        # vcs_info_msg_0_ is non-empty so we will use 3 line prompt
        echo "
${vcs_info_msg_0_}"
    fi
}


# check whether terminal supports colors and other belss and whistles
if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
    PROMPT='[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}${Z_HOST}%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}]$(prompt_repo_line)
%# '
    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
    RPROMPT='${return_code}%{$reset_color%}'
else
    PROMPT='[%n@${Z_HOST}:%~]%(prompt_repo_line)
%# '
    # display exitcode on the right when >0
    return_code="%(?..%? ↵)"
    RPROMPT='${return_code}'
fi

#PROMPT='%B%F{magenta}%c%B%F{green}${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}%%# '
autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd


# * Aliases

# ** Git
alias g='git'
alias ga='git add'
alias gau='git add --update'
alias gcmsg='git commit -m'
alias gcan='git commit -v -a --no-edit --amend'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gd='git diff'
alias gst='git status'
alias grhh='git reset --hard HEAD'
alias gcm='git checkout master'

# ** Mercurial
alias hgst='hg status'
alias hgcm='hg commit -m'

# ** Grep
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

# ** Editor
alias e="emacsclient -c -a ''"
alias te="emacsclient -t -a ''"
alias et="emacsclient -t -a ''"

# ** Directories
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'
alias rd='rm -rf'
# List directory contents
if [[ $Z_OS = "osx" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias lt="ls -laht"

# ** Useful 
# find file with name
alias ff='find . -type f -name'
# find directory with name
alias fd='find . -type d -name'
alias h='history'
alias hgrep="fc -El 0 | grep"
# user's processes
alias p='ps -f'
# head/tail/grep and silencing std(out|err)
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"


# * Machine ( OS and HOST ) Specific Configuration
# Various System Specific Configurations
[[ -f "${ZSH}/spec/${Z_OS}.zsh" ]] && source "${ZSH}/spec/${Z_OS}.zsh"
[[ -f "${ZSH}/spec/${Z_HOST}.zsh" ]] && source "${ZSH}/spec/${Z_HOST}.zsh"


# * TODO: Review Other Configuration

# opam configuration
test -r ${HOME}/.opam/opam-init/init.zsh && . ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#autoload -U +X bashcompinit && bashcompinit
#complete -o nospace -C /usr/bin/terraform terraform

#
#  ZSH configuration
#
#  This  configuration is  shared among multiple machines, so I try to accomodate all of their specifics
# 
#  Author: Evgeniy Sharapov
#

# * Options

# Perform parameter expansion, command substitution and arithmetic expansion in prompts
setopt prompt_subst

# avoid "no match" message 
setopt no_nomatch

# **  History 
# More history is saved 
HISTSIZE=100000
SAVEHIST=$HISTSIZE
# avoid duplicates
# https://wiki.archlinux.org/index.php/zsh#Preventing_duplicate_lines_in_the_history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# ignore following command (see http://zsh.sourceforge.net/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell)


# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# override customization for OMZ
ZSH_CUSTOM="${HOME}/.zsh_custom"
# loading our theme
ZSH_THEME="eshar"
#ZSH_THEME="kphoen"
# we don't want to auto-update
DISABLE_AUTO_UPDATE="true"
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
# Plugins do/should check for the command provided
plugins+=(git git-extras mercurial bundler rvm npm npx)


# * ZSH Settings
# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)
# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit

# ** Completions
# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi
compinit -i -d "${ZSH_COMPDUMP}"


# * PROMPT

# ** Theme (VCS Info)
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
    PROMPT='[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}]$(prompt_repo_line)
%# '
    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
    RPROMPT='${return_code}%{$reset_color%}'
else
    PROMPT='[%n@%m:%~]%(prompt_repo_line)
%# '
    # display exitcode on the right when >0
    return_code="%(?..%? ↵)"
    RPROMPT='${return_code}'
fi

#PROMPT='%B%F{magenta}%c%B%F{green}${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}%%# '
autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd


# * Aliases

# useful aliases
alias e="emacsclient -c -a ''"
alias te="emacsclient -t -a ''"
alias et="emacsclient -t -a ''"
alias lt="ls -laht"
alias thg="thg.exe &"
alias dhs="du -hs"
# do not put them in history
alias gst=" gst"
alias l=" l"
alias ll=" ll"

# * Machine ( OS and HOST ) Specific Configuration
# Figure out what OS/Host we are on
Z_OS=$(( cat /etc/*-release 2>/dev/null | sed -n 's/^ID=\(.*\)/\1/p' ))

if [ -z $Z_OS ]; then
    # could be MacOSX or Windows
    if [[ "$OSTYPE" == darwin* ]]; then
        Z_OS=osx
    else
        Z_OS=win
    fi
fi
# short name -s option is not always supported
Z_HOST=${$(hostname)//.*/}
# Various System Specific Configurations
[[ -f "${HOME}/.zshrc.${Z_OS}" ]] && source "${HOME}/.zshrc.${Z_OS}"
[[ -f "${HOME}/.zshrc.${Z_HOST}" ]] && source "${HOME}/.zshrc.${Z_HOST}"



# * Other Configuration

# Customize to your needs...
export LESS=' -R '

## Loading OMZ
source $ZSH/oh-my-zsh.sh

# opam configuration
test -r ${HOME}/.opam/opam-init/init.zsh && . ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

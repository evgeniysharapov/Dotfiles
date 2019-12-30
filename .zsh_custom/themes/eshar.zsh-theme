# This is customized theme for using with OMZ
#
# Evgeniy Sharapov
#
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
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
           zstyle ':vcs_info:git*' formats '%F{yellow}%s%f on %F{green}%b%f%u%c '
       } else {
           # some files we are not tracking by git
           zstyle ':vcs_info:git*' formats '%F{yellow}%s%f on %F{green}%b%f%u%c* '
       }
       # for hg git branch is less important than bookmark
       
    zstyle ':vcs_info:hg*' formats '%F{yellow}%s%f on %F{green}%m%f%u%c '

    vcs_info
}

setopt prompt_subst

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
    PROMPT='[%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}]
${vcs_info_msg_0_}%# '
    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
    RPROMPT='${return_code}%{$reset_color%}'
else
    PROMPT='[%n@%m:%~]
${vcs_info_msg_0_}%# '
   # display exitcode on the right when >0
    return_code="%(?..%? ↵)"
    RPROMPT='${return_code}'
fi

#PROMPT='%B%F{magenta}%c%B%F{green}${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}%%# '
autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd



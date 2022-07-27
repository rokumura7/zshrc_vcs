#!/bin/zsh
setopt +o nomatch

# show current branch name
function rprompt_git_current_branch {
  local branch_name
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [ -n "$branch_name" ]; then
    echo "%B%F{29}◀%f%K{29}%F{15} $branch_name %f%k%b"
  fi
}

# show icon
function prompt_working_time {
  local now
  now=$(date '+%H')
  if [ $now -eq 14 ]; then
    echo "🥦"
  elif [ $now -ge 19 -o $now -lt 10 ]; then
    echo "🤤"
  else
    echo "🍣"
  fi
}

# show aws profile
function rprompt_awsprof_precmd {
  profile="${AWS_PROFILE}"
  if [[ -n "${profile}" ]]; then
    echo "/ AWS PROFILE: %B%F{15}%K{38}${profile}%k%f%b"
  fi
}

# change aws profile
function awsp() {
  if [ $# -ge 1 ]; then
    export AWS_PROFILE="$1"
    echo "Set AWS_PROFILE=$AWS_PROFILE."
  else
    source _awsp
  fi
  export AWS_DEFAULT_PROFILE=$AWS_PROFILE
}

setopt prompt_subst
RPROMPT='%F{99}%D{%H:%M:%S}%f'
PROMPT='%F{33}%~%f `rprompt_git_current_branch` `rprompt_awsprof_precmd`
 `prompt_working_time`  ▶  '

##### PYTHON #####
eval "$(pyenv init -)"

##### GitHub CLI #####
eval "$(gh completion -s zsh)"

##### ALIAS #####
## ls
alias ls='ls -aG'
alias ll='ls -l'

## git
alias glo='git log --oneline'
alias gbl="git for-each-ref refs/heads/ --sort='committerdate' --format='%(committerdate:short) %(refname:short)'"
alias ggraph='git log --graph --date-order -C -M --pretty=format:"<%h> %ad [%an] %Cgreen%d%Creset %s" --all --date=short'

function gfpr() {
  command git fetch upstream pull/$1/head:PR_$1
}

export PATH=/opt/homebrew/bin:$PATH
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

export NODE_OPTIONS=--max_old_space_size=4096
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
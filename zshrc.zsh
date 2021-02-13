function rprompt_git_current_branch {
  local branch_name
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if [ -n "$branch_name" ]; then
    echo "%B%F{29}◀%f%K{29}%F{15} $branch_name %f%k%b"
  fi
}

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

setopt prompt_subst
RPROMPT='%F{99}%D{%H:%M:%S}%f'
PROMPT='%F{33}%~%f `rprompt_git_current_branch`
 `prompt_working_time`  ▶  '


##### ALIAS #####
## ls
alias ls='ls -aG'
alias ll='ls -l'

## git
alias glo='git log --oneline'
alias gbl="git for-each-ref refs/heads/ --sort='committerdate' --format='%(committerdate:short) %(refname:short)'"
alias ggraph='git log --graph --date-order -C -M --pretty=format:"<%h> %ad [%an] %Cgreen%d%Creset %s" --all --date=short'


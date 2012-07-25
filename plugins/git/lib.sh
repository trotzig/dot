git () {
  ssh-ensure-agent
  command git "$@"
}

active_git_branch () {
  local ref=`git symbolic-ref HEAD 2> /dev/null`
  echo "${ref#refs/heads/}"
}

git_branch_ahead () {
  local branch=`active_git_branch`
  `git log origin/$branch..HEAD 2> /dev/null | grep '^commit' &> /dev/null` \
    && echo '➨'
}

git_tree_status() {
  local index="$(git status --porcelain 2>/dev/null)"

  local reset='\033[0m'
  local red='\033[00;31m'
  local bright_red='\033[01;31m'

  local untracked=''
  local modified=${FG[136]}±${reset}
  local added=${FG[64]}✚${reset}
  local deleted=${red}✗${reset}
  local renamed=${FG[166]}®${reset}
  local unmerged=${bright_red}⊁${reset}

  local statusline=''
  if `echo "$index" | grep '^?? ' &> /dev/null`; then
    statusline="$untracked$statusline"
  fi
  if $(echo "$index" | grep '^A ' &> /dev/null); then
    statusline="$added$statusline"
  fi
  if $(echo "$index" | grep '^.\{0,1\}M ' &> /dev/null); then
    statusline="$modified$statusline"
  elif $(echo "$index" | grep '^ T ' &> /dev/null); then
    statusline="$modified$statusline"
  fi
  if $(echo "$index" | grep '^R ' &> /dev/null); then
    statusline="$renamed$statusline"
  fi
  if $(echo "$index" | grep '^.\{0,1\}D ' &> /dev/null); then
    statusline="$deleted$statusline"
  fi
  if $(echo "$index" | grep '^UU ' &> /dev/null); then
    statusline="$unmerged$statusline"
  fi

  echo -ne $statusline
}

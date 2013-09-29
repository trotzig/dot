alias g=git

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

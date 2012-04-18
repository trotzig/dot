# Runs after a command is executed (or interrupted),
# before the prompt is rendered for the next command.
precmd () {
  # Display exit code if non-zero
  local ret=$?
  if [ ! $ret -eq 0 ]; then
    echo -e "\033[0;31m→ exit status: $ret\033[0m" >&2
  fi

  # Update terminal title bar if one is available
  if [[ "$TERM" =~ xterm* ]]; then
    echo -en "\033]0;$(__prompt_user)@$(__prompt_host):$(__prompt_curdir)\007"
  fi
}

# Prompt escape variables differ between shells, so use functions instead
__prompt_user () { whoami; }
__prompt_host () { hostname; }
__prompt_curdir () {
  local dir=`pwd`
  echo "${dir/#$HOME/~}"
}

__git_prompt () {
  local branch=`active_git_branch`
  if [ ! -z "$branch" ]; then
    echo " $branch`git_tree_status`"
  else
    echo ""
  fi
}

__virtualenv_prompt () {
  local env=`active_virtual_env`
  if [ ! -z "$env" ]; then
    echo -ne " $env"
  fi
}

PS1="${RESET}${FG[240]}\$(__prompt_user)${RESET}"
PS1="${PS1}${FG[234]}@${FG[245]}\$(__prompt_host)${RESET}"
PS1="${PS1}${FG[234]}:${FG[136]}\$(__prompt_curdir)${RESET}"
PS1="${PS1}${FG[64]}\$(__git_prompt)${RESET}"
PS1="${PS1}${FG[61]}\$(__virtualenv_prompt)${RESET}"
PS1="${PS1}
${FG[240]}\$(current_shell)${FG[33]}⨠ ${RESET}"

# Prompt to display at beginning of next line when command spans multiple lines
PS2="${FG[33]}↳${RESET} "

# Debug line prefix
PS4="→ `[ "$0" != -bash ] && echo ${FG[64]}$0:${FG[33]}$LINENO || echo` ${RESET}"

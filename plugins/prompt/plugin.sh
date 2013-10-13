# Runs after a command is executed (or interrupted),
# before the prompt is rendered for the next command.
precmd() {
  # Display exit code if non-zero
  local ret=$?
  if [ ! $ret -eq 0 ]; then
    echo -e "\033[0;31m→ exit status: $ret\033[0m" >&2
  fi

  # Update terminal title bar if one is available
  if [[ "$TERM" =~ xterm* ]]; then
    echo -en "\033]0;$USER@$(hostname):$(__prompt_curdir)\007"
  fi
}

# Prompt escape variables differ between shells, so use functions instead
__prompt_curdir() {
  local dir="$PWD"
  echo "${dir/#$HOME/~}"
}

# Display the currently git branch and status if we're in a git repository
__git_prompt() {
  local branch=`active_git_branch`
  if [ ! -z "$branch" ]; then
    echo " `git_branch_ahead`$branch"
  else
    echo ""
  fi
}

# Display currently active Python virtual environment if one exists
__virtualenv_prompt() {
  local env=`active_virtual_env`
  if [ ! -z "$env" ]; then
    echo -ne " $env"
  fi
}

# Main prompt line
PS1="${PSTARTLINE}${PRESET}${PFG[240]}\$USER${PRESET}"
PS1="${PS1}${PFG[234]}@${PFG[245]}\$(hostname -s)${PRESET}"
PS1="${PS1}${PFG[234]}:${PFG[136]}\$(__prompt_curdir)${PRESET}"
PS1="${PS1}${PFG[64]}\$(__git_prompt)${PRESET}"
PS1="${PS1}${PFG[61]}\$(__virtualenv_prompt)${PRESET}"
PS1="${PS1}
${PFG[33]}⨠ ${PRESET}"

# Prompt to display at beginning of next line when command spans multiple lines
PS2="${PFG[33]}↳${PRESET} "

# Debug line prefix
PS4="→ `[ "$0" != -bash ] && echo ${FG[64]}$0:${FG[33]}$LINENO || echo` ${RESET}"

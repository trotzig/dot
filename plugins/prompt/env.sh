# Main prompt line
PS1="${PRESET}${PFG[240]}\$USER${PRESET}"
PS1="${PS1}${PFG[234]}@${PFG[245]}\$(hostname)${PRESET}"
PS1="${PS1}${PFG[234]}:${PFG[136]}\$(__prompt_curdir)${PRESET}"
PS1="${PS1}${PFG[64]}\$(__git_prompt)${PRESET}"
PS1="${PS1}${PFG[61]}\$(__virtualenv_prompt)${PRESET}"
PS1="${PS1}
${PFG[240]}\$(current_shell)${PFG[33]}⨠ ${PRESET}"

# Prompt to display at beginning of next line when command spans multiple lines
PS2="${PFG[33]}↳${PRESET} "

# Debug line prefix
PS4="→ `[ "$0" != -bash ] && echo ${FG[64]}$0:${FG[33]}$LINENO || echo` ${RESET}"

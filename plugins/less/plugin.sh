# Use `less` as the default viewer for multi-page output
export PAGER=less

# Output ANSI control/colour sequences
export LESS="--RAW-CONTROL-CHARS"

export LESSHISTFILE="$DOTLOGDIR/less-history"

# `man` page colours
export LESS_TERMCAP_mb=$'\E[05;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;64m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_mr=$'\E[01;38;5;199m' # begin bold
export LESS_TERMCAP_so=$'\E[38;5;208m' # begin standout-mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_us=$'\E[04;38;5;33m' # begin underline
export LESS_TERMCAP_ue=$'\E[0m' # end underline

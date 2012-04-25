# Colorize `ls` output using dircolors settings
if [ "$TERM" != "dumb" ]; then
  eval `dircolors $DOTPLUGIN/dircolors`
fi

# Common shortcuts
alias ls="ls --color=auto -h"
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'

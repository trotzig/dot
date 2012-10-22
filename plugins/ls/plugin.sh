# Colorize `ls` output using dircolors settings
if [ "$TERM" != "dumb" ]; then
  eval `dircolors $DOTPLUGIN/dircolors`
fi

# Common shortcuts (don't care if there are previous mappings defined by system)
forcealias ls="ls --color=auto -h"
forcealias la='ls -a'
forcealias ll='ls -l'
forcealias lal='ls -al'

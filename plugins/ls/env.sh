# Colorize `ls` output using dircolors settings
if [ "$TERM" != "dumb" ]; then
  eval `dircolors $DOTPLUGIN/dircolors`
fi

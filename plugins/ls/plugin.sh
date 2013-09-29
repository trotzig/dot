if [ `uname` = Darwin ]; then
  # Prefer GNU coreutils instead of Mac look-alikes
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

  # Ensure we see documentation for GNU versions of utils
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Colorize `ls` output using dircolors settings
if [ "$TERM" != "dumb" ]; then
  eval `dircolors $DOTPLUGIN/dircolors`
  forcealias ls="ls --color=auto"
fi

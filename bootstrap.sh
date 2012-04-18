# Shell bootstrap script run for all interactive shells.
#
# To activate, have .bash_profile/.zshrc/etc. define an environment variable
# DOTDIR pointing to the location of this repository, and source this file.

[ -z "$DOTDIR" ] && echo '$DOTDIR environment variable not set' && exit 1

bootstrap () {
  # Load library of helper functions and initialize global environment
  source "$DOTDIR/shell/lib.sh"
  source "$DOTDIR/shell/env.sh"

  # Source files from environment and library directories
  for dir in `echo "lib env" | words`; do
    local exts=sh
    local shell=`current_shell`

    if [ "$shell" != sh ]; then
      # Include custom shell extension in list of files to source
      exts="$exts $shell"
    fi

    # Source the generic .sh files first, then the shell-specific ones
    for ext in `echo $exts | words`; do
      for file in `find $DOTDIR/$dir -maxdepth 1 -name "*.$ext"`; do
        source $file
      done
    done
  done
}

bootstrap && unset bootstrap

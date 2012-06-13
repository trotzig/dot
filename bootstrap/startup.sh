# Shell bootstrap script run for all interactive shells.
#
# To activate, have .bash_profile/.zshrc/etc. define an environment variable
# DOTDIR pointing to the location of this repository, and source this file.

[ -z "$DOTDIR" ] && echo '$DOTDIR environment variable not set' && exit 1

bootstrap () {
  # Load library of helper functions and initialize global environment
  source "$DOTDIR/bootstrap/lib.sh"
  source "$DOTDIR/bootstrap/env.sh"

  local exts=sh
  local shell=`current_shell`

  # For each plugin
  for DOTPLUGIN in `find $DOTPLUGINSDIR -type d -mindepth 1 -maxdepth 1`; do
    # Source files from environment and library files
    for type in `echo "lib env" | words`; do

      if [ "$shell" != sh ]; then
        # Include custom shell extension in list of files to source
        exts="$exts $shell"
      fi

      # Source the generic .sh files first, then the shell-specific ones
      for ext in `echo $exts | words`; do
        if [ -s "$DOTPLUGIN/$type.$ext" ]; then
          source "$DOTPLUGIN/$type.$ext"
        fi
      done
    done
  done
}

bootstrap && unset bootstrap

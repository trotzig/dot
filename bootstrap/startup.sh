# Shell bootstrap script run for all interactive shells.
#
# To activate, have .bash_profile/.zshrc/etc. define an environment variable
# DOTDIR pointing to the location of this repository, and source this file.

[ -z "$DOTDIR" ] && echo '$DOTDIR environment variable not set' && exit 1

# Load library of helper functions and initialize global environment
source "$DOTDIR/bootstrap/lib.sh"
source "$DOTDIR/bootstrap/env.sh"
source "$DOTDIR/bootstrap/update.sh"

check_for_dot_update () {
  local last_check_file="$DOTTMPDIR/dot-last-check-time"
  local current_day=`date -u +%Y-%m-%d`

  if [ ! -e "$last_check_file" ]; then
    touch "$last_check_file"
  fi

  if [ "`cat $last_check_file`" != "$current_day" ]; then
    echo "$current_day" > "$DOTTMPDIR/dot-last-check-time"

    read -p "Check for updates to Dot? (y/n) "
    if [ "$REPLY" == "y" ] && update_dot; then
      # Reload the updated version of this script if an update occurred
      source "$DOTDIR/bootstrap/startup.sh"
      return 1
    else
      echo "Execute '$DOTDIR/update' to update Dot manually at any time"
    fi
  fi
}

bootstrap () {
  local exts=sh
  local shell=`current_shell`

  if ! check_for_dot_update; then
    return # Reload occurred
  fi

  # Include shell-specific extension in list of files to source after .sh files
  if [ "$shell" != sh ]; then
    exts="$exts $shell"
  fi

  # For each plugin...
  for DOTPLUGIN in `find $DOTPLUGINSDIR -mindepth 1 -maxdepth 1 -type d`; do
    # Source environment and library files
    for type in `words lib env`; do
      # Source the generic .sh files first, then the shell-specific ones
      for ext in `words $exts`; do
        if [ -s "$DOTPLUGIN/$type.$ext" ]; then
          source "$DOTPLUGIN/$type.$ext"
        fi
      done
    done

    # Perform any shell-specific tasks for loading this plugin
    local src_file="$DOTDIR/bootstrap/plugin.$shell"
    if [ -s "$src_file" ]; then
      source "$src_file"
    fi
  done

  # Perform any final shell-specific tasks
  for ext in `words $exts`; do
    local src_file="$DOTDIR/bootstrap/finish.$ext"
    if [ -s "$src_file" ]; then
      source "$src_file"
    fi
  done
}

bootstrap && unset bootstrap

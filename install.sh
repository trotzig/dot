#!/usr/bin/env bash

# Sets .bash_profile and .zshrc to load this framework, and runs any
# installation scripts in the install directory (setting up symlinks, etc.)
#
# This script and any installation scripts should be idempotent.

set -e

# Define DOTDIR as location of this repository
export DOTDIR="$( cd "$( dirname "$0" )" && pwd )"

source "$DOTDIR/bootstrap/lib.sh"

backup () {
  local file=$1
  cp -r "$file" "$file.bak"
}

# Helper for installing symlinks, taking care of backups/etc.
install_symlink () {
  local target_file=$1
  local source_file=$2

  if [ -e "$target_file" ]; then
    if [ "`readlink $target_file`" = "$source_file" ]; then
      return
    fi
    backup "$target_file" && rm -rf $target_file
  fi

  ln -sf "$source_file" "$target_file"
}

# Write shell config files to point to bootstrap script
for file in `echo ".bash_profile .zshrc" | words`; do
  tmp_file="$TMPDIR/$file"
  conf_file="$HOME/$file"

  cat > "$tmp_file" <<EOF
export DOTDIR="$DOTDIR"
source "\$DOTDIR/bootstrap/startup.sh"
EOF

  # Backup any previously existing file (unless it's from another installation)
  if [ -e "$conf_file" ]; then
    if [ ! -z "`diff --ignore-blank-lines --ignore-space-change \
         $tmp_file $conf_file`" ]; then
      backup "$conf_file" || exit 1
    fi
  fi

  mv "$tmp_file" "$conf_file"
done

for install_script in `find $DOTDIR/plugins -name "install.sh"`; do
  # Define variable for each plugin so install script can use it for convenience
  DOTPLUGIN=`dirname $install_script`
  # Each script defines an `install` function which we call
  source "$install_script" && install && unset install
done

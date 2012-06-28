#!/usr/bin/env bash

# Sets .bash_profile and .zshrc to load this framework, and runs any
# installation scripts in the install directory (setting up symlinks, etc.)
#
# This script and any installation scripts should be idempotent.

set -e

backup () {
  local file=$1
  cp -r "$file" "$file.bak"
}

install_dot_plugin () {
  local plugin_name=$1
  local plugin_dir="$DOTPLUGINSDIR/$plugin_name"
  local script="$plugin_dir/install.sh"

  # Define variable so plugin install script can use it for convenience
  DOTPLUGIN="$plugin_dir"
  source "$script" && install && unset install && unset DOTPLUGIN
}

install_repo () {
  local repo_url=$1
  local repo_dest=$2 # optional
  local commit=$3    # optional

  # Default to current plugin directory if none specified
  if [ -z "$repo_dest" ]; then
    repo_dest="$DOTPLUGIN/$(basename -s .git $repo_url)"
  fi

  if [ -d "$repo_dest/.git" ]; then
    # Repo already exists; update it
    (cd "$repo_dest" && git pull > /dev/null)
  else
    git clone "$repo_url" "$repo_dest"
  fi

  if [ -n "$commit" ]; then
    (cd "$repo_dest" && git reset --hard "$commit")
  fi
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

main () {
  local plugin_to_install=$1 # Can optionally specify plugin

  # Define DOTDIR as location of this repository
  export DOTDIR="$( cd "$( dirname "$0" )" && pwd )"

  source "$DOTDIR/bootstrap/lib.sh"
  source "$DOTDIR/bootstrap/env.sh"

  # If a specific plugin name was specified, only install that plugin
  if [ -n "$plugin_to_install" ]; then
    install_dot_plugin $plugin_to_install
    return
  fi

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

  for install_script in `find $DOTPLUGINSDIR -name "install.sh"`; do
    install_dot_plugin "$(basename $(dirname $install_script))"
  done
}

main "$@"

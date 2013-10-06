alias t=tmux

tmux() {
  # Symlink auth socket so that when we reconnect we can point to the newer
  # socket by just updating the symlink. Saves us from having to manually reset
  # SSH_AUTH_SOCK using `ssh-reagent` or similar.
  SOCK_SYMLINK=~/.ssh/tmux_ssh_auth_sock
  if [ -r "$SSH_AUTH_SOCK" ]; then
    rm -f $SOCK_SYMLINK && ln -s $SSH_AUTH_SOCK $SOCK_SYMLINK
    tmux_command="env SSH_AUTH_SOCK=$SOCK_SYMLINK `which tmux`"
  else
    tmux_command=`which tmux`
  fi


  if [ -z "$@" ]; then
    # Attach to session with the current directory name if one exists,
    # otherwise automatically create a session with the current directory name
    $tmux_command new -A -s "$(basename $(pwd))"
  else
    $tmux_command "$@"
  fi
}

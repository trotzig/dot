alias t=tmux

tmux() {
  # Symlink auth socket so that when we reconnect we can point to the newer
  # socket by just updating the symlink. Saves us from having to manually reset
  # SSH_AUTH_SOCK using `ssh-reagent` or similar.
  SOCK_SYMLINK=~/.ssh/tmux_ssh_auth_sock
  [ -r $SSH_AUTH_SOCK ] && ln -sf $SSH_AUTH_SOCK $SOCK_SYMLINK

  tmux_command="env SSH_AUTH_SOCK=$SOCK_SYMLINK `which tmux`"

  if [ -z "$@" ]; then
    local dir=`basename $(pwd)`
    # Attach to session with the current directory name if one exists,
    # otherwise automatically create a session with the current directory name
    $tmux_command attach-session -t "$dir" || \
      $tmux_command new-session -s "$dir"
  else
    $tmux_command "$@"
  fi
}

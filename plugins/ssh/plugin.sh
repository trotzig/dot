# Convenience function to ensure an agent exists before ssh-ing
ssh () {
  ssh-ensure-agent
  command ssh "$@"
}

ssh-ensure-agent () {
  if ! ssh-add -l &> /dev/null; then
    ssh-reagent &> /dev/null
  fi
}

# Reinitialize SSH_AUTH_SOCK environment variable to point to a working SSH
# agent socket. One situation where the need for this occurs is when your
# connection drops while in a tmux session. The session will have its
# SSH_AUTH_SOCK variable pointing to the old agent socket, but a new one will
# have been created when you reconnected. This script finds the new agent socket
# and uses it as your agent by setting SSH_AUTH_SOCK.
ssh-reagent () {
  if ls /tmp/ssh-*/agent.* &> /dev/null; then # If socket(s) exists
    for agent in /tmp/ssh-*/agent.*; do
      export SSH_AUTH_SOCK=$agent
      echo "Trying $agent"
      # In rare cases, running `ssh-add -l` will hang on an invalid agent
      # socket, so we run it with the `timeout` script to kill it if it hangs.
      if $DOTPLUGIN/timeout -t 1 ssh-add -l &> /dev/null; then
        echo Found working SSH Agent:
        ssh-add -l
        return
      else
        # Ignore the agent if the socket doesn't respond; we don't delete it
        # since it may just be some weirdness happening that prevents it from
        # working the first time (very unsatisfactory explanation, I know).
        echo "Agent $agent appears dead; ignoring"
      fi
    done
  fi
  echo Cannot find SSH agent--maybe you should reconnect and forward it?
  return 1
}

# Reinitialize env vars for ssh-agent; useful when TMUX loses it
ssh_reagent () {
  for agent in /tmp/ssh-*/agent.*; do
    export SSH_AUTH_SOCK=$agent
    if ssh-add -l &> /dev/null; then
      echo Found working SSH Agent:
      ssh-add -l
      return
    fi
  done
  echo Cannot find SSH agent - maybe you should reconnect and forward it?
}

# Intended to be run before each command.
# This saves me from having to remember to reconnect to my agent
# after it gets disconnected in a TMUX session
ssh_ensure_agent () {
  if ! ssh-add -l &> /dev/null; then
    ssh-reagent &> /dev/null
  fi
}

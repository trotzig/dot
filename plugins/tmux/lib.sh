# Automatically name sessions to the directory from which we started tmux
tmux () {
  if [ -z "$@" ]; then
    local dir=`basename $(pwd)`
    # Attach to session with the current directory name if one exists,
    # otherwise automatically create a session with the current directory name
    command tmux attach-session -t "$dir" || command tmux new-session -s "$dir"
  else
    command tmux "$@"
  fi
}

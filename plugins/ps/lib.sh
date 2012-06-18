# Search for a process by name
psgrep () {
  ps aux | grep "$@" | grep -v grep
}

# Kills any process that matches a regexp passed to it
pskill () {
  psgrep "$@" | awk '{print $2}' | xargs kill
}

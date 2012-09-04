# Defines utility functions that are used by Dot.

# Returns a string representing the shell running this script
current_shell () {
  local shell=sh

  if [ -n "$BASH_VERSION" ]; then
    shell=bash
  elif [ -n "$ZSH_VERSION" ]; then
    shell=zsh
  fi

  echo "$shell"
}

# Sets an alias safely, printing an error if alias is already in use.
alias () {
  local mapping=$1

  # Redirect to builtin behaviour if no mapping provided
  if [ -z "$mapping" ]; then
    builtin alias "$@"
    return $?
  fi

  local alias_name=`echo $mapping | cut -d'=' -f 1`

  if [ -z "`builtin alias $alias_name 2>/dev/null`" ]; then
    builtin alias "$@"
  else
    echo "Error: $alias_name already aliased to `builtin alias $alias_name`"
    return 1
  fi
}

# Ignore any previous alias mappings in certain cases
# (so we don't get a warning on startup of an alias already existing)
forcealias () {
  builtin alias "$@"
}

# Print words from string onto separate lines
words () {
  echo "$@" | tr -s " " "\012"
}

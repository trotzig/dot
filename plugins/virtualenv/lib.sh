active_virtual_env () {
  [[ -n "$VIRTUAL_ENV" ]] && echo -n `basename $VIRTUAL_ENV`
}

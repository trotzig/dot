setup() {
  if [ `uname` = Darwin ]; then
    formula tmux
    formula reattach-to-user-namespace
  fi

  symlink "$HOME/.tmux.conf" "$DOTPLUGIN/tmux.conf"
}

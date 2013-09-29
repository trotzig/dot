setup() {
  if [ `uname` = Darwin ]; then
    formula ack
  fi

  symlink "$HOME/.ackrc" "$DOTPLUGIN/ackrc"
}

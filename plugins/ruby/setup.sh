setup() {
  if [ `uname` = Darwin ]; then
    formula rbenv
    formula ruby-build
  fi

  symlink "$HOME/.irbrc" "$DOTPLUGIN/irbrc"
  symlink "$HOME/.pryrc" "$DOTPLUGIN/pryrc"
}

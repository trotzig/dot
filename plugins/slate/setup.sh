setup () {
  if [ `uname` = Darwin ]; then
    symlink "$HOME/.slate" "$DOTPLUGIN/slate"
  fi
}

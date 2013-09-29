setup () {
  if [ `uname` = Darwin ]; then
    formula ctags
  fi

  symlink "$HOME/.ctags" "$DOTPLUGIN/ctags"
}

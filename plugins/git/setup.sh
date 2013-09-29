setup () {
  if [ `uname` = Darwin ]; then
    formula git
  fi

  symlink "$HOME/.gitconfig" "$DOTPLUGIN/gitconfig"
  symlink "$HOME/.gitignore" "$DOTPLUGIN/gitignore"
}

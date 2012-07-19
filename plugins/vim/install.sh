install () {
  install_repo 'git@github.com:sds/.vim.git' "$DOTPLUGIN/.vim"

  install_symlink "$HOME/.vim" "$DOTPLUGIN/.vim"
  install_symlink "$HOME/.vimrc" "$HOME/.vim/init.vim"

  # Update all Vim plugins
  (cd $DOTPLUGIN/.vim && $DOTPLUGIN/.vim/update.sh)
}

setup () {
  repo "git@github.com:sds/.vim.git" "$DOTPLUGIN/.vim"
  symlink "$HOME/.vim" "$DOTPLUGIN/.vim"
  symlink "$HOME/.vimrc" "$HOME/.vim/init.vim"
}

install () {
  (cd $DOTPLUGIN/.vim && $DOTPLUGIN/.vim/update)
}

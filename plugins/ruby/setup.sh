setup() {
  if [ `uname` = Darwin ]; then
    formula rbenv
    formula ruby-build
  fi
}

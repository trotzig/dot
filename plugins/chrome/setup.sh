setup() {
  if [ `uname` = Darwin ]; then
    cask google-chrome
    cask google-hangouts # Voice plugin
  fi
}

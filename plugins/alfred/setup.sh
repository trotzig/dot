setup() {
  if [ `uname` = Darwin ]; then
    cask alfred
  fi
}

install() {
  if [ `uname` = Darwin ]; then
    # Add cask room to Alfred's index of paths to search for applications
    if [[ `brew cask alfred status` =~ "not linked" ]]; then
      brew cask alfred link
    fi
  fi
}

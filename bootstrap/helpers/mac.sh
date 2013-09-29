# Installs a Mac .pkg file from a URL
install_package() {
  url=$1
  cache_dir=/tmp/dotfiles/packages
  filename=`basename $url`
  pkg="${cache_dir}/${filename}"

  mkdir -p $cache_dir

  # Download package if we don't already have it cached
  if [ ! -s "$pkg" ]; then
    [ ! -f "$pkg" ] && pkg=`mktemp $pkg`
    curl --location --output $pkg $url
  fi

  sudo install -pkg $pkg -target / && rm $pkg
}

formula_installed() {
  formula=$1
  ! brew info $formula | grep "Not installed" >/dev/null 2>&1
}

install_formula() {
  formula=$1
  if ! formula_installed $formula; then
    brew install $formula
  fi
}

uninstall_formula() {
  formula=$1
  if formula_installed $formula; then
    brew uninstall $formula
  fi
}

# Declarative syntax for specifying a Homebrew formula should be installed
formula() {
  formula=$1

  if installing; then
    install_formula $formula
  else
    uninstall_formula $formula
  fi
}

cask_installed() {
  cask=$1
  ! brew cask info $cask | grep "Not installed" >/dev/null 2>&1
}

install_cask() {
  cask=$1
  cask_installed $cask || brew cask install $cask
}

uninstall_cask() {
  cask=$1
  cask_installed $cask && brew cask uninstall $cask
}

# Declarative syntax for specifying a Homebrew cask should be installed
cask() {
  cask=$1

  if installing; then
    install_cask $cask
  else
    uninstall_cask $cask
  fi
}

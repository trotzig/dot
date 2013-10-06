ensure_homebrew_installed() {
  if [ ! $(command -v brew) ]; then
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    brew install git # Commonly used so just install it now
  fi

  if ! brew cask >/dev/null 2>&1; then
    brew tap phinze/homebrew-cask
    brew install brew-cask
  fi
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

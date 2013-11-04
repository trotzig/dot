ensure_xcode_clt_installed() {
  if $(pkgutil --pkg-info=com.apple.pkg.DeveloperToolsCLI >/dev/null); then
    return # Already have XCode Command Line Tools installed
  fi

  dmg="$DOTDIR/tmp/clitools.dmg"
  if [ ! -f "$dmg" ]; then
    dmg_url=`python $DOTDIR/bootstrap/helpers/xcode-clt-url.py`
    curl -L "$dmg_url" -o "$dmg"
  fi

  tmp_mount=`/usr/bin/mktemp -d /tmp/clitools.XXXX`
  hdiutil attach "$dmg" -mountpoint "$tmp_mount" -nobrowse
  sudo installer -pkg "$(find $tmp_mount -name '*.mpkg')" -target /
  hdiutil detach "$tmp_mount"
  rm -rf "$tmp_mount"
}

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
  plist=$2 # Optional plist to load/unload with launchctl

  if installing; then
    install_formula $formula
    if [ -n "$plist" ]; then
      launchctl load $HOME/Library/LaunchAgents/$plist
    fi
  else
    if [ -n "$plist" ]; then
      launchctl unload $HOME/Library/LaunchAgents/$plist
    fi
    uninstall_formula $formula
  fi
}

cask_installed() {
  cask=$1
  ! brew cask info $cask | grep "Not installed" >/dev/null 2>&1
}

install_cask() {
  cask=$1
  if ! cask_installed $cask; then
    brew cask install $cask
  fi
}

uninstall_cask() {
  cask=$1
  if cask_installed $cask; then
    brew cask uninstall $cask
  fi
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

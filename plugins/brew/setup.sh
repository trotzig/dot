# We don't support uninstalling
install() {
  if ! in_path gcc; then
    install_package "https://github.com/downloads/kennethreitz/osx-gcc-installer/GCC-10.7-v2.pkg"
  fi

  if ! in_path brew; then
    curl --location --output install-brew.rb "raw.github.com/mxcl/homebrew/go"
    /usr/bin/ruby install-brew.rb
    rm install-brew.rb
  fi

  if ! brew cask >/dev/null 2>&1; then
    brew tap phinze/homebrew-cask
    brew install brew-cask
  fi
}

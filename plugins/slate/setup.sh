install() {
  if [ `uname` = Darwin ]; then
    # Ensure Assistive Devices are enabled for Slate
    sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db \
      "INSERT OR REPLACE INTO access VALUES('kTCCServiceAccessibility','com.slate.Slate',0,1,1,NULL);"
  fi
}

setup() {
  if [ `uname` = Darwin ]; then
    cask slate
    symlink "$HOME/.slate" "$DOTPLUGIN/slate"
  fi
}

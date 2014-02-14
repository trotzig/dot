install() {
  if [ `uname` = Darwin ]; then
    # Ensure Assistive Devices are enabled for Shortcat
    sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db \
      "INSERT OR REPLACE INTO access VALUES('kTCCServiceAccessibility','com.sproutcube.Shortcat',0,1,1,NULL);"
  fi
}

setup() {
  if [ `uname` = Darwin ]; then
    cask shortcat
  fi
}

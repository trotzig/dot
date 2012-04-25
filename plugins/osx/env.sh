if [ `uname` = Darwin ]; then
  alias vim='mvim -v'
  alias finder='/usr/bin/osascript -e "tell application \"Finder\" to open POSIX file \"`pwd`\""'
fi

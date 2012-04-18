# Editing shortcuts
alias reload='. ~/.profile; echo .profile reloaded'
alias aliases="$EDITOR $DOTDIR/conf/aliases; reload"
alias sshconfig="$EDITOR ~/.ssh/config"

# Common shortcuts
alias ls="ls --color=auto -h"
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'
alias g='git'
alias sc='screen $SHELL -c "cd \"$PWD\" && exec $SHELL --login"'
alias t='tmux'

# Curl
alias delete='curl --silent -i -XDELETE'
alias get='curl --silent -i -XGET'
alias post='curl --silent -i -XPOST'
alias put='curl --silent -i -XPUT'

# Mac
if [ `uname` = Darwin ]; then
  alias vim='mvim -v'
  alias finder='/usr/bin/osascript -e "tell application \"Finder\" to open POSIX file \"`pwd`\""'
fi

# Typos/shortcuts
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias :e='vim'
alias vi='vim'
alias :q='exit'

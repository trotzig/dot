setup () {
  file "$HOME/.psqlrc" <<EOF
\\\set DOTDIR '$DOTDIR'
\\\i $DOTPLUGIN/psqlrc
EOF
}

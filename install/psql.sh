install () {
  local target_file="$HOME/.psqlrc"

  if [ -e "$target_file" ]; then
    backup "$target_file"
  fi

  # Create .psqlrc that sources our config
  # (so that we can also make local customizations)
  cat > "$target_file" <<EOF
\set DOTDIR '$DOTDIR'
\i $DOTDIR/conf/psqlrc
EOF
}

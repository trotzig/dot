# Automatically source bash completion scripts if they exist
if [ -s "$DOTPLUGIN/completion.bash" ]; then
  source "$DOTPLUGIN/completion.bash"
fi

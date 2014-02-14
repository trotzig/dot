# Colorize prompt. We need a newline because MySQL counts the characters used to
# do colour coding in the prompt width, preventing the command from taking up
# the full width of the terminal since it thinks the prompt is wider than it
# actually is. The newline avoids this entirely by resetting the line.
export MYSQL_PS1="${RESET}${FG[240]}\\u ${FG[245]}\\d ${RESET}\\n⨠ "

# Location of mysql client command history file
export MYSQL_HISTFILE="$DOTLOGDIR/mysql-history"

# Open new screen in the same directory as the current screen
alias sc='screen $SHELL -c "cd \"$PWD\" && exec $SHELL --login"'

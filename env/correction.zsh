# Attempt to correct spelling of all arguments in a command
setopt correct_all

# Don't autocorrect for these utilities as it doesn't make sense to
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'

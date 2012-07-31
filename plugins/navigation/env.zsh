# If command can't be executed, and is the name of a directory, cd into it
setopt auto_cd

# Automatically push directory onto stack when changing directories
setopt auto_pushd

# Don't push multiple copies of same directory onto stack
setopt pushd_ignore_dups

# If argument to cd command exists if we assume a ~ in front, include the ~
setopt cdable_vars

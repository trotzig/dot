# Defines environment variables and other settings that are used everywhere

# Use applications from local user bin if one exists
export PATH=$HOME/bin:$PATH

export PAGER=less
export EDITOR=vim
export VISUAL=$EDITOR

# Make working with colour escape codes easier
init_colours () {
  RESET="[00m"
  BOLD="[01m"
  ITALIC="[03m"
  UNDERLINE="[04m"
  BLINK="[05m"
  REVERSE="[07m"

  if [ `current_shell` = zsh ]; then
    typeset -Ag FX FG BG
  fi

  for color in {0..255}; do
    FG[$color]="[38;5;${color}m"
    BG[$color]="[48;5;${color}m"
  done

  colours () {
    for code in {0..255}; do
      echo "${reset}$code: ${FG[$code]}Test"
    done
  }
}
init_colours && unset init_colours

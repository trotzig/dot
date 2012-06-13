# Defines environment variables and other settings that are used everywhere

# Directory that any log files should be stored in
export DOTLOGDIR="$DOTDIR/log"

# Prefer applications from home bin if one exists
export PATH="$HOME/bin:$PATH"

# Make working with colour escape codes easier
init_colours () {
  local prefix=''
  local suffix=''
  local shell=`current_shell`

  # Stops bash/zsh from counting escape sequences as characters.
  # This prevents the PS1 prompt from counting
  case "$shell" in
    bash)
      prefix='\['
      suffix='\]'
      ;;
    zsh)
      prefix='%{'
      suffix='%}'
  esac

  # Escape sequence for prompts
  PRESET="$prefix[00m$suffix"
  PBOLD="$prefix[01m$suffix"
  PITALIC="$prefix[03m$suffix"
  PUNDERLINE="$prefix[04m$suffix"
  PBLINK="$prefix[05m$suffix"
  PREVERSE="$prefix[07m$suffix"
  # TODO: Write a script that checks the current cursor column, and only resets
  # the cursor if the column is not the first column
  #PSTARTLINE="$prefix[G$suffix" # Move cursor to the start of current line
  PSTARTLINE=""

  RESET="[00m"
  BOLD="[01m"
  ITALIC="[03m"
  UNDERLINE="[04m"
  BLINK="[05m"
  REVERSE="[07m"

  if [ `current_shell` = zsh ]; then
    typeset -Ag FG BG PFG PBG
  fi

  for color in {0..255}; do
    FG[$color]="[38;5;${color}m"
    BG[$color]="[48;5;${color}m"
    PFG[$color]="$prefix[38;5;${color}m$suffix"
    PBG[$color]="$prefix[48;5;${color}m$suffix"
  done

  colours () {
    for code in {0..255}; do
      echo "${reset}$code: ${FG[$code]}Test"
    done
  }
}
init_colours && unset init_colours

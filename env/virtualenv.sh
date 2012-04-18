# Don't prepend ugly "(virtualenv_name)" to prompt when activating env.
# PS1 has been set to display virtualenv if one is activated.
export VIRTUAL_ENV_DISABLE_PROMPT=true

if [ -s "/usr/local/bin/virtualenvwrapper.sh" ]; then
  source "/usr/local/bin/virtualenvwrapper.sh"

  # Set directory where virtualenvs are created.
  export WORKON_HOME=~/.virtualenvs
  export PIP_VIRTUALENV_BASE=$WORKON_HOME
fi

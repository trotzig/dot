# Enable autocompletion for pip (only available for bash/zsh)
shell=`current_shell`
if [[ "$shell" =~ (ba|z)sh ]]; then
  which pip >/dev/null 2>&1 && \
    eval `PIP_REQUIRE_VIRTUALENV=false pip completion --$shell`
fi

# Require virtualenv when installing packages with pip.
# Temporarily override by prefixing command with PIP_REQUIRE_VIRTUALENV=false
export PIP_REQUIRE_VIRTUALENV=true

export PYENV_ROOT="$ZDOTDIR/pyenv"

prepend_path_if_exists "${PYENV_ROOT}/bin"
prepend_path_if_exists "$ZDOTDIR/pyenv-register/bin"
prepend_path_if_exists "$ZDOTDIR/pyenv-virtualenv/bin"
prepend_path_if_exists "$ZDOTDIR/pyenv-virtualenvwrapper/bin"

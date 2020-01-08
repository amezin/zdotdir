if (( $+commands[virtualenvwrapper_lazy.sh] )); then
  . $commands[virtualenvwrapper_lazy.sh]

  function workon_cwd {
    local PROJECT_ROOT="${PWD:A}"
    while [[ "$PROJECT_ROOT" != "/" && ! -e "$PROJECT_ROOT/.venv" ]]; do
      PROJECT_ROOT="${PROJECT_ROOT:h}"
    done
    if [[ "$PROJECT_ROOT" == "/" ]]; then
      PROJECT_ROOT="."
    fi

    # Check for virtualenv name override
    if [[ -f "$PROJECT_ROOT/.venv" ]]; then
      local PROJECT_VIRTUAL_ENV_NAME="$(cat "$PROJECT_ROOT/.venv")"
      local PROJECT_VIRTUAL_ENV="$WORKON_HOME/$PROJECT_VIRTUAL_ENV_NAME"
      PROJECT_VIRTUAL_ENV="${PROJECT_VIRTUAL_ENV:P}"
      if [[ "$PROJECT_VIRTUAL_ENV" != "${VIRTUAL_ENV:P}" ]] && [[ "$PROJECT_VIRTUAL_ENV" != "${AUTO_ACTIVATED_VIRTUAL_ENV:P}" ]]; then
        workon -n "$PROJECT_VIRTUAL_ENV_NAME" && AUTO_ACTIVATED_VIRTUAL_ENV="$VIRTUAL_ENV"
      fi
    elif [[ -n "$VIRTUAL_ENV" ]] && [[ -d "$VIRTUAL_ENV" ]]; then
      if [[ "$AUTO_ACTIVATED_VIRTUAL_ENV" == "$VIRTUAL_ENV" ]]; then
        deactivate
        unset AUTO_ACTIVATED_VIRTUAL_ENV
      fi
    else
      unset AUTO_ACTIVATED_VIRTUAL_ENV
    fi
  }

  autoload -U add-zsh-hook
  add-zsh-hook chpwd workon_cwd
fi

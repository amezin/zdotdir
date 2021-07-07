if (( $+commands[virtualenvwrapper_lazy.sh] )); then
  . $commands[virtualenvwrapper_lazy.sh]

  function workon_cwd {
    local PROJECT_FILE
    local PROJECT_DIR
    local PROJECT_VIRTUAL_ENV

    for PROJECT_FILE in "${WORKON_HOME:P}"/*/.project; do
      local TRY_PROJECT_DIR="$(cat "$PROJECT_FILE")"
      TRY_PROJECT_DIR="${TRY_PROJECT_DIR:P}"
      if [[ "${PWD:P}/" == "$TRY_PROJECT_DIR"/* ]]; then
        if (( ${#TRY_PROJECT_DIR} > ${#PROJECT_DIR} )); then
          PROJECT_DIR="$TRY_PROJECT_DIR"
          PROJECT_VIRTUAL_ENV="${PROJECT_FILE:h}"
        fi
      fi
    done

    # Check for virtualenv name override
    if [[ -n "$PROJECT_VIRTUAL_ENV" ]]; then
      if [[ "$PROJECT_VIRTUAL_ENV" != "${VIRTUAL_ENV:P}" ]] && [[ "$PROJECT_VIRTUAL_ENV" != "${AUTO_ACTIVATED_VIRTUAL_ENV:P}" ]]; then
        workon -n "${PROJECT_VIRTUAL_ENV:t}" && AUTO_ACTIVATED_VIRTUAL_ENV="$VIRTUAL_ENV"
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

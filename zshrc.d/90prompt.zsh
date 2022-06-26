fpath+=("${ZDOTDIR}/powerlevel9k")

autoload -Uz promptinit
promptinit

if [[ -z "$POWERLEVEL9K_MODE" ]]; then
    if [[ -n "$DESKTOP_SESSION" || -n "$XDG_DESKTOP_SESSION" || -n "$XDG_CURRENT_DESKTOP" ]]; then
        if command -V fc-match >/dev/null; then
            if [[ "$(fc-match -f '%{family[0]}' ':charset=f489')" == "Symbols Nerd Font" ]]; then
                POWERLEVEL9K_MODE=nerdfont-fontconfig
            fi
        fi
    fi
fi

if [[ -z "$POWERLEVEL9K_MODE" ]]; then
    POWERLEVEL9K_MODE=compatibility

    if [[ "$TERM" != (dumb|linux|*bsd*|eterm*) ]]; then
        POWERLEVEL9K_EXECUTION_TIME_ICON=$'\u231B'
        POWERLEVEL9K_TIME_ICON=$'\u231A'
    fi
fi

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S %d.%m.%y}"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0.01
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2

POWERLEVEL9K_STATUS_OK=false

VIRTUAL_ENV_DISABLE_PROMPT=1

POWERLEVEL9K_CUSTOM_NIX_SHELL='echo -n ${(M)IN_NIX_SHELL:#(pure|impure)}'

case $POWERLEVEL9K_MODE in
    'nerdfont-complete'|'nerdfont-fontconfig')
        POWERLEVEL9K_CUSTOM_NIX_SHELL_ICON=$'\uF313'
    ;;
    *)
        POWERLEVEL9K_CUSTOM_NIX_SHELL_ICON='nix'
    ;;
esac

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs pyenv virtualenv custom_nix_shell)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status root_indicator background_jobs time)

zstyle ':vcs_info:*' choose-closest-backend yes

prompt powerlevel9k

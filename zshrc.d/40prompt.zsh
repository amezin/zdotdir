fpath+=("${ZDOTDIR}/powerlevel9k")

autoload -Uz promptinit
promptinit

if true; then
    POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\u258C'
    POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\u2590'
    POWERLEVEL9K_EXECUTION_TIME_ICON=$'\u23F1'

    POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0.01
    POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2

    VIRTUAL_ENV_DISABLE_PROMPT=1

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs pyenv virtualenv)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status root_indicator background_jobs history time)

    prompt powerlevel9k

else
    export POWERLINE_CONFIG_PATHS="${ZDOTDIR}/powerline/powerline/config_files:${ZDOTDIR}/powerline-config"

    "${ZDOTDIR}/bin/powerline-daemon" -q
    source "${ZDOTDIR}/powerline/powerline/bindings/zsh/powerline.zsh"

    zmodload zsh/datetime
    zmodload zsh/mathfunc

    _last_command_duration_preexec() {
        _last_command_duration_start=${_last_command_duration_start:-$EPOCHREALTIME}
    }

    _last_command_duration_precmd() {
        if [ $_last_command_duration_start ]; then
            local duration=$(($EPOCHREALTIME - $_last_command_duration_start))
            unset _last_command_duration_start

            local humanReadableDuration

            if (( duration > 3600 )); then
                humanReadableDuration=$(TZ=GMT; strftime '%H:%M:%S' $(( int(rint(duration)) )))
            elif (( duration > 60 )); then
                humanReadableDuration=$(TZ=GMT; strftime '%M:%S' $(( int(rint(duration)) )))
            else
                typeset -F 2 humanReadableDuration
                humanReadableDuration=$duration

                if (( $humanReadableDuration == 0 )); then
                    unset _LAST_COMMAND_DURATION_HUMAN_READABLE
                    return
                fi
            fi

            export _LAST_COMMAND_DURATION_HUMAN_READABLE="$humanReadableDuration"
        fi
    }

    precmd_functions+=(_last_command_duration_precmd)
    preexec_functions+=(_last_command_duration_preexec)
fi

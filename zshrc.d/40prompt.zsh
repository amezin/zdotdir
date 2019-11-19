autoload -Uz promptinit
promptinit

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

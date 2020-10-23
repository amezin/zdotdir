fpath+=("${ZDOTDIR}/powerlevel9k")

autoload -Uz promptinit
promptinit

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\u258C'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\u2590'

if [[ "$TERM" != "linux" ]]; then
    POWERLEVEL9K_EXECUTION_TIME_ICON=$'\u23F1'
    POWERLEVEL9K_TIME_FORMAT="\u231A %D{%H:%M:%S %d.%m.%y}"
fi

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0.01
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2

POWERLEVEL9K_STATUS_OK=false

VIRTUAL_ENV_DISABLE_PROMPT=1

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs pyenv virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status root_indicator background_jobs time)

zstyle ':vcs_info:hg:*:*' get-revision yes
zstyle ':vcs_info:hg:*:*' check-for-changes yes
zstyle ':vcs_info:*' find-deepest yes

prompt powerlevel9k

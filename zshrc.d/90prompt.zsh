fpath=("${ZDOTDIR}/theme" "${fpath[@]}")

autoload -Uz promptinit
promptinit

if [[ "$TERM" != "linux" ]]; then
    POWERLEVEL9K_EXECUTION_TIME_ICON=$'\u23F1'
    POWERLEVEL9K_TIME_FORMAT="\u231A %D{%H:%M:%S %d.%m.%y}"
fi

zstyle ':vcs_info:*' get-revision yes
zstyle ':vcs_info:*' get-bookmarks yes
zstyle ':vcs_info:*' get-unapplied yes
zstyle ':vcs_info:*' check-for-changes yes
zstyle ':vcs_info:*' find-deepest yes

prompt my

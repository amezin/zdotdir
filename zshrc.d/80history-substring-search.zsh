source "${ZDOTDIR}/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   history-substring-search-up
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" history-substring-search-down

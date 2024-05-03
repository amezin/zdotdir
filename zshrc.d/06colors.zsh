if (( terminfo[colors] >= 8 )); then

  # ls Colours
  if (( ${+commands[dircolors]} )); then
    # GNU

    source "${ZDOTDIR}/LS_COLORS/lscolors.sh"

    alias ls='ls --group-directories-first --color=auto'
  else
    # BSD

    (( ! ${+CLICOLOR} )) && export CLICOLOR=1
    (( ! ${+LSCOLORS} )) && export LSCOLORS='ExfxcxdxbxGxDxabagacad'

    # stock OpenBSD ls does not support colors at all, but colorls does.
    if [[ ${OSTYPE} == openbsd* && ${+commands[colorls]} -ne 0 ]]; then
      alias ls='colorls'
    fi
  fi

  # grep Colours
  (( ! ${+GREP_COLOR} )) && export GREP_COLOR='37;45'               #BSD
  (( ! ${+GREP_COLORS} )) && export GREP_COLORS="mt=${GREP_COLOR}"  #GNU
  if [[ ${OSTYPE} == openbsd* ]]; then
    (( ${+commands[ggrep]} )) && alias grep='ggrep --color=auto'
  else
   alias grep='grep --color=auto'
  fi

  # less Colours
  if [[ ${PAGER} == 'less' ]]; then
    (( ! ${+LESS_TERMCAP_mb} )) && export LESS_TERMCAP_mb=$'\E[1;31m'   # Begins blinking.
    (( ! ${+LESS_TERMCAP_md} )) && export LESS_TERMCAP_md=$'\E[1;31m'   # Begins bold.
    (( ! ${+LESS_TERMCAP_me} )) && export LESS_TERMCAP_me=$'\E[0m'      # Ends mode.
    (( ! ${+LESS_TERMCAP_se} )) && export LESS_TERMCAP_se=$'\E[0m'      # Ends standout-mode.
    (( ! ${+LESS_TERMCAP_so} )) && export LESS_TERMCAP_so=$'\E[7m'      # Begins standout-mode.
    (( ! ${+LESS_TERMCAP_ue} )) && export LESS_TERMCAP_ue=$'\E[0m'      # Ends underline.
    (( ! ${+LESS_TERMCAP_us} )) && export LESS_TERMCAP_us=$'\E[1;32m'   # Begins underline.
  fi
fi

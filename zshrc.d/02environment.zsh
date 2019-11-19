autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

# Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt AUTO_RESUME

# Allow comments starting with `#` even in interactive shells.
setopt INTERACTIVE_COMMENTS

# List jobs in the long format by default.
setopt LONG_LIST_JOBS

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt NOTIFY

# Prevent runing all background jobs at a lower priority.
setopt NO_BG_NICE

# Prevent reporting the status of background and suspended jobs before exiting a shell with job control.
# NO_CHECK_JOBS is best used only in combination with NO_HUP, else such jobs will be killed automatically.
setopt NO_CHECK_JOBS

# Prevent sending the HUP signal to running jobs when the shell exits.
setopt NO_HUP

# Remove path separtor from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Set less or more as the default pager.
if (( ! ${+PAGER} )); then
  if (( ${+commands[less]} )); then
    export PAGER=less
  else
    export PAGER=more
  fi
fi

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  (( ! ${+BROWSER} )) && export BROWSER='open'
fi

#
# Editors
#

(( ! ${+EDITOR} )) && export EDITOR='nano'
(( ! ${+VISUAL} )) && export VISUAL='nano'

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

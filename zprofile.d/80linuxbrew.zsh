if [ -x ~/.linuxbrew/bin/brew ]; then
  eval "$(~/.linuxbrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

for file in "$ZDOTDIR"/zshrc.d/*.zsh
do
  source "$file"
done

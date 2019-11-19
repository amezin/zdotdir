for file in "$ZDOTDIR"/zprofile.d/*.zsh
do
  source "$file"
done

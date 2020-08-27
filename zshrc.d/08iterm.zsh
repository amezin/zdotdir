if [[ -v ITERM_SESSION_ID ]]; then
    if [[ -e /Applications/iTerm.app/Contents/Resources/iterm2_shell_integration.zsh ]]; then
        source /Applications/iTerm.app/Contents/Resources/iterm2_shell_integration.zsh
    fi
fi

typeset -U PATH path

prepend_path_if_exists() {
    for p in "$@"
    do
        if [ -d "$p" ] # && [[ $path[(ie)$p] -le ${#path} ]]
        then
            path=("$p" $path)
        fi
    done
}

prepend_path_if_exists /opt/local/bin /opt/local/sbin
#prepend_path_if_exists /usr/lib/ccache /usr/lib/ccache/bin /usr/local/opt/ccache/libexec
prepend_path_if_exists "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
prepend_path_if_exists /Applications/CMake.app/Contents/bin
prepend_path_if_exists /home/linuxbrew/.linuxbrew/bin
prepend_path_if_exists "$HOME/Library/Android/sdk/platform-tools"
prepend_path_if_exists "/Applications/Wine Devel.app/Contents/Resources/wine/bin"
prepend_path_if_exists "$HOME/depot_tools"
prepend_path_if_exists "$HOME/.krew/bin"

if command -v ruby >/dev/null
then
    prepend_path_if_exists "$(ruby -rrubygems -e 'puts Gem.user_dir')/bin"
fi

if command -v python3 >/dev/null
then
    prepend_path_if_exists "$(python3 -c 'import sysconfig; print(sysconfig.get_path("scripts"))')"
    prepend_path_if_exists "$(python3 -c 'import sysconfig; print(sysconfig.get_path("scripts", "posix_user"))')"
fi

prepend_path_if_exists "$HOME/.local/bin"
prepend_path_if_exists "$ZDOTDIR/bin"

export PATH

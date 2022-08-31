if (( $+commands[npm] )); then
    NPM_PREFIX="$(npm prefix -g)"

    if [[ "$NPM_PREFIX" != "/usr" && "$NPM_PREFIX" != "/usr/local" ]]; then
        path=("$NPM_PREFIX/bin" $path)

        # Preserve MANPATH if you already defined it somewhere in your config.
        # Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
        export MANPATH="${MANPATH-$(manpath)}:${NPM_PREFIX}/share/man"
    fi
fi

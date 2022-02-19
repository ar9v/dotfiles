if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# ENVIRONMENT VARIABLES
export EDITOR="/usr/bin/emacsclient -c"
export VISUAL="$EDITOR"
export INFOPATH="/usr/share/info:/usr/local/share/info"

# If we add the $HOME var in env-paths, it is not expanded
# when we use sed to filter out commented paths in the file
# As a workaround, and since these are all $HOME paths, we simply
# use $HOME from the script
paths=$(sed -n {/^[^#]/p} env-paths)
for path in ${paths}
do
    PATH="$PATH:$HOME/${path}"
done
# Home
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Tex-Live Manager script
export TEXMFDIST="/usr/share/texmf-dist"

# opam configuration
test -r /home/argv/.opam/opam-init/init.sh && . /home/argv/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

session-choose.sh && startx

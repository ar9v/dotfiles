if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# ENVIRONMENT VARIABLES
export EDITOR="/usr/bin/emacsclient -c"
export VISUAL="$EDITOR"
export INFOPATH="/usr/share/info:/usr/local/share/info"
export RANGER_LOAD_DEFAULT_RC="FALSE"

# Home
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH

export TERM=xterm-256color

# Tex-Live Manager script
export TEXMFDIST="/usr/share/texmf-dist"

# Library (my library program) env vars
# export LIBRARY_PATH="$HOME/Documents/library"

# session-choose.sh && startx

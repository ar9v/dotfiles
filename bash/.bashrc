PS1=$'\[\e[0;36m\]\u\[\e[0;37m\]@\[\e[1;31m\]\h \[\e[1;32m\]\W \[\e[1;34m\]\u03bb \[\e[0m\]'

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Source aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function for ranger to automatically change directory when it is quit
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    $(which ranger) --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

bind '"\C-o":"ranger-cd\C-m"'

# Autorun tmux on a graphical display
if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]
then
    [ -z "$TMUX" ] && (tmux attach || tmux) >/dev/null 2>&1
fi

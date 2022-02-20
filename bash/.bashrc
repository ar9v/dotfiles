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

# Autorun tmux on a graphical display
if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]
then
    [ -z "$TMUX" ] && (tmux attach || tmux) >/dev/null 2>&1
fi

# Key bindings
bind '"\C-o":"ranger-cd\C-m"'

# Env setups
eval "$(rbenv init - bash)"

if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

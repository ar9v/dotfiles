# PS1

PS1=`./ps1`

#PS1=$'\n\[\e[0;34m\]\u\[\e[0m\]@\[\e[1;31m\]\h \[\e[1;32m\]\W \[\e[1;34m\]\n  \[\e[1;35m\] \u03bb \[\e[0m\]'

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

# Key bindings
bind '"\C-o":"ranger-cd\C-m"'
bind '"RET":"hello"'

# Env setups
eval "$(rbenv init - bash)"

if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

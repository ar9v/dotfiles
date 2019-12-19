# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# PATH setup
## set PATH so it includes user's private bin if it exists
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
PATH="$PATH:/home/niyx/.emacs.d/bin/"

## rbenv setup (path and init for shell integration)
export PATH="$PATH:/home/niyx/.rbenv/bin"
if [ -d ~/.rbenv/bin ]
then
    eval "$(rbenv init -)"
fi

## Yarn setup
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

## ENVIRONMENT VARIABLES

# Sets my EDITOR variable so as to use Emacs
export EDITOR='/usr/bin/emacs'

# run program to manage sessions
# session-choose
startx

#if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
#    startx
#fi

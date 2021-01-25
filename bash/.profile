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

# ENVIRONMENT VARIABLES
export EDITOR='/usr/bin/emacs'
export INFOPATH="/usr/share/info:/usr/local/share/info"

export PATH="$PATH:$HOME/.emacs.d/bin/"
export PATH="$PATH:$HOME/doom-emacs/bin/"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Rather crude, but this way startx isn't run if something
# fails on session-choose.sh
#
# We check for the SHLVL as a hack to avoid running this in,
# say, tmux
[ $SHLVL -eq 1 ] && session-choose.sh && startx

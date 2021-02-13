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

# If we add the $HOME var in env-paths, it is not expanded
# when we use sed to filter out commented paths in the file
# As a workaround, and since these are all $HOME paths, we simply
# use $HOME from the script
paths=$(sed -n {/^[^#]/p} env-paths)
for path in ${paths}
do
    PATH="$PATH:$HOME/${path}"
done
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

session-choose.sh && startx

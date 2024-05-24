PS1="; "

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

PROJECT_PATH_PREFIX="/home/argv/src/"

# Functions
function fd_immediate_dir_basenames_in () {
    # fd-immediate-dir-basenames-in DIR_PATH
    #
    # Show dirs in depth 1 from `dir_path`, and only show their basenames
    # (-L: follow symlinks)
    local dir_path="$1"

    fd -t d -d 1 -L . "$dir_path" -X printf "%s\n" {/}
}

function fzf_cd_in () {
    #  fzf-cd-in DIR_PATH_PREFIX
    #
    # Show `dir_path_prefix`'s directories thru fzf, and cd to the
    # selection
    local dir_path_prefix="$1"

    local target="`fd_immediate_dir_basenames_in "$dir_path_prefix" | fzf`"

    cd "${dir_path_prefix}${target}"
}

function srz () { fzf_cd_in "$PROJECT_PATH_PREFIX" ; }

function src () {
    local proj="$1"

    if [ -n "$proj" ]
    then
        cd "$PROJECT_PATH_PREFIX/$proj"
    else
        cd "$PROJECT_PATH_PREFIX"
    fi
}

function cd_dotfiles() {
    local dotilfes_path_prefix="/home/argv/dotfiles/"

    fzf_cd_in "$dotilfes_path_prefix"
}

function vin {
   local program_path=$1

   vim `which $program_path`
}

function clone_proj () { src && git clone "$1" ; }

# Key bindings
bind '"\C-o":". ranger\C-m"'
bind -m emacs-ctlx '",":"srz\C-m"'
bind -m emacs-ctlx '".":"cd_dotfiles\C-m"'


# Env setups

## Ruby
eval "$(rbenv init - bash)"

## JS
source /usr/share/nvm/init-nvm.sh

## Haskell
[ -f "/home/argv/.ghcup/env" ] && source "/home/argv/.ghcup/env" # ghcup-env

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

# Source the system-wide file.
[ -f /etc/bashrc ] && source /etc/bashrc

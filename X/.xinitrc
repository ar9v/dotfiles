#!/bin/bash

# Set the wallpaper
sh ~/.fehbg &

# X commands
xmodmap .Xmodmap
xset b off # Turns off the bell
xsetroot -cursor_name left_ptr
xrdb -merge .Xresources

picom -b 
emacs --daemon
dunst &

# This is a workaround, since flameshot uses dbus
# I'll have to check for stumpwm dbus support
flameshot &

# session-choose.sh writes to last-session
# this way we don't have to version control last-session
# nor do we have the issue of constantly modifying xinitrc,
# which is version controlled
exec $(cat last-session)

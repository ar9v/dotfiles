#!/bin/bash

# Set the wallpaper
#sh ~/.fehbg &

# X commands
xmodmap .Xmodmap
xset b off # Turns off the bell
xsetroot -cursor_name left_ptr
xrdb -merge .Xresources
sh ~/.screenlayout/right.sh &

picom -b 

# A brief note:
# When running pacman -Syu (and consequently borking sbcl; having
# inconsistent sbcls between the system and Stumpwm) running emacs --daemon
# will hang since "package cl is deprecated"; just a heads up
emacs --daemon

dunst &
imwheel -b 45
sxhkd &

# session-choose.sh writes to last-session
# this way we don't have to version control last-session
# nor do we have the issue of constantly modifying xinitrc,
# which is version controlled
exec $(cat last-session)

#!/bin/bash

# Wallpaper script
#sh ~/.fehbg &

# X commands
xmodmap .Xmodmap
xset b off # Turns off the bell
xsetroot -cursor_name left_ptr
xrdb -merge .Xresources
sh ~/.screenlayout/left.sh &

picom -b 

emacs --daemon

dunst &
imwheel -b 45
sxhkd &

# NOTE: `last-session` is written to by `session-choose.sh`
exec $(cat last-session)

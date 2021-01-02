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

#exec i3
exec stumpwm

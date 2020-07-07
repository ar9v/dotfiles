#!/bin/bash

sh ~/.fehbg &

# X commands
xmodmap .Xmodmap
xset b off # Turns off the bell
xsetroot -cursor_name left_ptr
xrdb -merge .Xresources

compton &

exec stumpwm

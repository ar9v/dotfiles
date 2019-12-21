#!/bin/bash

xmodmap .xmodmap
sh ~/.fehbg &
xsetroot -cursor_name left_ptr
xrdb -merge .Xresources
compton &
exec /usr/local/bin/stumpwm 

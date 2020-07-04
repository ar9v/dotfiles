#!/bin/bash

xmodmap .Xmodmap
sh ~/.fehbg &
xsetroot -cursor_name left_ptr
xrdb -merge .Xresources
picom &
exec stumpwm

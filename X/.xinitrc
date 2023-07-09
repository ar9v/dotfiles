#!/bin/bash

function isMonitorConnected () {
    xrandr -q | grep -q "HDMI-2 connected"
}

# X commands
xmodmap .Xmodmap

if isMonitorConnected
then
    sh ~/.screenlayout/solo.sh &
else
    sh ~/.screenlayout/left.sh &
fi

picom -b 

emacs --daemon

dunst &
sxhkd &

# NOTE: `last-session` is written to by `session-choose.sh`
exec $(cat last-session)

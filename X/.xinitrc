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
redshift -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | awk 'OFS=":" {print $3,$5}' | tr -d ',}') &

exec $(tail -1 ~/last-session)

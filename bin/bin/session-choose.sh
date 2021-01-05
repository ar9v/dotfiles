#!/bin/bash

# Script to choose a window manager
# Simply add or remove wms to the wms array
wms=( stumpwm i3 openbox-session awesome )
wms_size=${#wms[@]}

echo # make some space

# Arrays are 0 indexed, so we must subtract one
# We use seq to be able to identify wms by their index
for index in $(seq 0 $((wms_size - 1)))
do
    echo [$index] - ${wms[$index]}
done

read -p "Choose your wm (defaults to ${wms[0]}): " id

if [[ $id > $((wms_size - 1)) ]]
then
   id=0
fi

session=${wms[$id]}

if command -v $session
then
    echo $session > last-session
else
    echo $session is not installed
    exit 1
fi

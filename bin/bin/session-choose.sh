#!/bin/bash

# Script to choose a window manager
# Simply add or remove wms to the wms array

wms=( stumpwm sway none )
wms_size=${#wms[@]}

echo 

# Arrays are 0 indexed, so we must subtract one
# We use seq to be able to identify wms by their index
for index in $(seq 0 $((wms_size - 1)))
do
    echo ["$index"] - "${wms[$index]}"
done

read -p "Choose your wm (defaults to ${wms[0]}): " id

if [[ "$id" > "$((wms_size - 1))" ]]
then
   id=0
fi


chosen_wm="${wms[$id]}"
echo $chosen_wm
wm_path=$(command -v $chosen_wm)

case "$chosen_wm" in
    none) 
        exit 1
        ;;
    sway)
        start-sway.sh
        ;;
    *)
        if [[ -n "$wm_path" ]]
        then
            echo $wm_path > ~/last-session && startx
        else
            echo "$chosen_wm is not installed"
            exit 1
        fi
        ;;
esac

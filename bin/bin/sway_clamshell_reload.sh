#!/bin/sh

LAPTOP_OUTPUT="eDP-1"
LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

read -r LID_STATE < "$LID_STATE_FILE"

case "$LID_STATE"
  *open) swaymsg output "$LAPTOP_OUTPUT" enable ;;
  *closed) swaymsg output "$LAPTOP_OUTPUT" disable ;;
  *) echo 'Could not get lid state' >&2 ; exit 1 ;;
esac
	   

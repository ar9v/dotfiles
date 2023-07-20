#!/usr/bin/env bash

function err () {
    echo "$1"
    exit 1
}

function check_args () {
    [[ "$#" -eq 1 ]] || err "Only one arg can be passed: on|off"    
}

function build_filename () {
    dirname="/sys/bus/usb/drivers/usb"
    case $1 in
	"on") echo "${dirname}/bind";;
	"off") echo "${dirname}/unbind";;
    esac
}

function main () {
    check_args "$@"
    
    filename=`build_filename "$@"`

    if [[ -z "$filename" ]]
    then
	err "invalid arg: use either on|off"
    else
	echo 2-3 | sudo tee "$filename"
    fi
}

main "$@"


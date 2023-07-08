#!/bin/bash

shopt -s extglob

JBL="78:44:05:8A:1B:53"
OPERATION=$1

# Usage
# 
# jbl.sh [c, d]
# jbl.sh c -> connects 
# jbl.sh d -> disconnects

usage() {
cat << EOF
Usage:

jbl.sh c(onnect) : connects JBL GO speaker
jbl.sh d(isconnect) : disconnects JBL GO speaker
EOF

exit 1;
}

case $OPERATION in
    c?(onnect)) bluetoothctl connect $JBL ;;
    d?(isconnect)) bluetoothctl disconnect $JBL ;;
    *) usage ;;
esac

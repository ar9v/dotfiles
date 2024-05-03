#!/usr/bin/env bash

# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway

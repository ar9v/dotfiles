#!/bin/bash

mplayer tv:// -tv driver=v4l2:device=/dev/video$1:width=960:height=544

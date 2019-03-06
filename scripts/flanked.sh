#!/bin/bash

xrandr --output eDP1 --mode 1920x1080
xrandr --output DVI-I-1-1 --off
xrandr --addmode VIRTUAL1 600x1080_60.00
xrandr --output VIRTUAL1 --mode "600x1080_60.00" --left-of eDP1
xrandr --addmode VIRTUAL2 600x1080_60.00
xrandr --output VIRTUAL2 --mode "600x1080_60.00" --right-of eDP1
xrandr --addmode VIRTUAL3 3120x1080_60.00
xrandr --output VIRTUAL3 --mode "3120x1080_60.00" --below VIRTUAL1

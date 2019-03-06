#!/bin/bash

xrandr --output VIRTUAL3 --off
xrandr --output eDP1 --mode 1920x1080
xrandr --output DVI-I-1-1 --mode 1920x1080
xrandr --addmode VIRTUAL1 1920x1080_60.00
xrandr --output VIRTUAL1 --mode "1920x1080_60.00" --below eDP1
xrandr --addmode VIRTUAL2 1920x1080_60.00
xrandr --output VIRTUAL2 --mode "1920x1080_60.00" --below DVI-I-1-1

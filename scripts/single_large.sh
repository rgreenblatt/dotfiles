#!/bin/bash

xrandr --addmode VIRTUAL1 4000x1500_60.00
xrandr --output VIRTUAL1 --mode 4000x1500_60.00
xrandr --output eDP1 --off 
xrandr --output DVI-I-1-1 --off 
xrandr --output VIRTUAL2 --off 
xrandr --output VIRTUAL3 --off 

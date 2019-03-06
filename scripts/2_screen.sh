#!/bin/bash

xrandr --output eDP1 --mode 1920x1080
xrandr --output DVI-I-1-1 --mode 1920x1080 --left-of eDP1
xrandr --output VIRTUAL1 --off 
xrandr --output VIRTUAL2 --off 
xrandr --output VIRTUAL3 --off 

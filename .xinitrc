#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

rm -rf /tmp/keyboard_info/ && mkdir /tmp/keyboard_info/ &
compton -b --config ~/.config/compton/compton.conf &
keyboard_setup &
low_battery_notify &
notify_setup &

# invoke global X session script
. /etc/X11/Xsession

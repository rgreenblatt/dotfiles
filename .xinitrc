#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

compton -b --config ~/.config/compton/compton.conf &
(mkdir -p /tmp/keyboard_info/ && touch /tmp/keyboard_info/kill && \
  sleep 1.0 && rm -f /tmp/keyboard_info/kill && keyboard_setup) &
low_battery_notify &
notify_setup &

# invoke global X session script
. /etc/X11/Xsession

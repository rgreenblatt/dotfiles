#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

twmnd &
compton -b --config ~/.config/compton/compton.conf
# (mkdir -p /tmp/keyboard_info/ && touch /tmp/keyboard_info/kill &&
#   sleep 1.0 && keyboard_setup) &
low_battery_notify &
notify_setup &
unclutter -idle 1.0 -root &
hsetroot -solid "#1d2021"
# download_lectures

# invoke global X session script
if [[ -f "/etc/X11/Xsession" ]]; then
  # just ubuntu?
  . /etc/X11/Xsession
else
  userresources=$HOME/.Xresources
  usermodmap=$HOME/.Xmodmap
  sysresources=/etc/X11/xinit/.Xresources
  sysmodmap=/etc/X11/xinit/.Xmodmap

  # merge in defaults and keymaps

  if [ -f $sysresources ]; then
      xrdb -merge $sysresources
  fi

  if [ -f $sysmodmap ]; then
      xmodmap $sysmodmap
  fi

  if [ -f "$userresources" ]; then
      xrdb -merge "$userresources"

  fi

  if [ -f "$usermodmap" ]; then
      xmodmap "$usermodmap"
  fi

  if [ -d /etc/X11/xinit/xinitrc.d ] ; then
   for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
   done
   unset f
  fi

  exec i3
fi

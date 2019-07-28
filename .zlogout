# TODO
if [[ -z $DISPLAY ]] && ([[ $(tty) == /dev/tty1 ]] ||
  [[ $(tty) == /dev/tty2 ]]); then
  rm -rf /tmp/keyboard_info && mkdir /tmp/keyboard_info &&
    nohup keyboard_setup &>/dev/null &
fi

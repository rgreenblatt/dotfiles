if [[ -z $DISPLAY ]] && ([[ $(tty) = /dev/tty1 ]] || [[ $(tty) = /dev/tty2 ]])
then
  nohup keyboard_setup &> /dev/null &
fi

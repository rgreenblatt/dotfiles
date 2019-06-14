# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh

if [[ -z $DISPLAY ]] && ([[ $(tty) = /dev/tty1 ]] || [[ $(tty) = /dev/tty2 ]])
then
  exec startx
fi

if hash yaft startx 2> /dev/null && [[ -z $DISPLAY ]] && 
  ([[ $(tty) = /dev/tty3 ]] || [[ $(tty) = /dev/tty4 ]])
then
  # sleep is needed for some reason
  sleep 0.3 && exec "yaft"
fi

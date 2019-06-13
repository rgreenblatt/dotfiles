# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh

if [[ -z $DISPLAY ]] && ([[ $(tty) = /dev/tty1 ]] || [[ $(tty) = /dev/tty2 ]])
then
  exec startx
fi

if hash yaft startx && [[ -z $DISPLAY ]] && ([[ $(tty) = /dev/tty3 ]] || 
  [[ $(tty) = /dev/tty4 ]])
then
  yaft
fi

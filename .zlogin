# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh

if [[ -z $DISPLAY ]] && ([[ $(tty) = /dev/tty1 ]] || [[ $(tty) = /dev/tty2 ]])
then
  exec startx
fi

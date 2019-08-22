#setup {{{1
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

if [ -z "$CONFIG_HOME" ]; then
  if [ -n "$SSHHOME" ]; then
    CONFIG_HOME="$SSHHOME/.sshrc.d"
  else
    CONFIG_HOME=$HOME
  fi
  export CONFIG_HOME
fi

export INTERATIVE_SHELL="bash"

source "$CONFIG_HOME/.shellrc"

#defaults from debian/ubuntu {{{1
HISTCONTROL=ignoreboth
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if hash dircolors 2>/dev/null; then
  (test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)") ||
    eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

#misc {{{1
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#}}}

# vim: set fdm=marker:

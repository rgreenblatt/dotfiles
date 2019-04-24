#setup {{{
if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh
#}}}

#prompt {{{
autoload -Uz promptinit
promptinit
prompt ryan black blue green yellow
#}}}

#bindings {{{
bindkey -v

autoload -z edit-command-line 
zle -N edit-command-line
bindkey "^E" edit-command-line

export KEYTIMEOUT=1
#}}}

#history {{{
setopt histignorealldups sharehistory

HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history
#}}}

#completion {{{
autoload -Uz compinit

#faster load, may require manual load after installs
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

compinit -C
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

setopt rm_star_silent
setopt +o nomatch

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
#}}}

#aliases {{{
#ls {{{
alias cs='cd'
alias l='exa'
alias ls='exa'
alias sl='exa'
alias ll='exa -l'
alias lg='exa -l --git'
alias lgi='exa -l --git --git-ignore'
alias lt='exa -T'
alias lr='exa -R'
#}}}

#docker {{{
alias d_run_bind='docker run -it -v $HOME:$HOME -w $PWD'
alias d_run_w_bind='~/.d_run_w_bind.sh'
alias d_eval_2016='eval $(docker-machine env 2016)'
alias d_eval_unset='eval $(docker-machine env -u)'
#}}}

#python {{{
alias py='python3'
alias python='python3'
alias pip='pip3'
#}}}

#generic {{{
alias o='xdg-open'
alias p='preview'
alias calc='python3 -ic "from math import *; import numpy as np"'
a='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
alias stime="$a"
alias d="disown %"

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g L="| bat"
alias -g F="| fzf"
alias -g NO="> /dev/null"
alias -g NE="2> /dev/null"
alias -g NA="&> /dev/null"

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias ff='rg --files -g'

alias h='history'
#}}}

#git {{{
#see https://github.com/zimfw/zimfw/tree/master/modules/git for list of aliases

mgs() {
  mgs_path=$(mgs_path $@)
  if [[ -n $mgs_path ]]; then
      cd $mgs_path
  fi
}

alias mgsd='mgs -e ~ 4'
#}}}

#slurm {{{
if hash scancel 2>/dev/null; then 
  alias cancel_all='scancel -u guest287'
fi 

if hash squeue 2>/dev/null; then 
  alias check='squeue -u guest287'
fi
#}}}

#mounting flash drive {{{
alias lm="lsblk"
alias am="udisksctl mount -b"
#}}}
#}}}

#nvim terminal specific settings {{{
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  alias h='nvr -o'
  alias v='nvr -O'
  alias t='nvr --remote-tab'
  alias e='nvr --remote'
  export GIT_TERMINAL_PROMPT=1
  export VISUAL='nvr -cc split --remote-wait -c "set bufhidden=delete"'
  export EDITOR="$VISUAL"

  highlight_term_color() {
    echo "highlight TermCursor ctermfg=$1 guifg=$1"
  }

  cursor_red="highlight TermCursor ctermfg=Red guifg=Red"
  cursor_blue="highlight TermCursor ctermfg=Blue guifg=Blue"

  #indicate insert vs normal mode zsh
  zle-keymap-select () {
    case $KEYMAP in
      vicmd) nvr -cc $cursor_blue --remote-send "<esc>";;
      viins|main) nvr -cc $cursor_red --remote-send "h<bs>";;
    esac
  }

  zle -N zle-keymap-select
fi
#}}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#thefuck (lazy loading) {{{
if command -v thefuck >/dev/null 2>&1; then
  a='if type fuck_alias &>/dev/null; then; fuck_alias; else;'
  b=' eval "$(thefuck --alias fuck_alias)"; fuck_alias; fi'
  alias f="$a$b"
fi
#}}}

#undistractify me (modified, also set term title) {{{
# export LONG_RUNNING_IGNORE_LIST="o cat xdg-open git gca gc f p gp"
export LONG_RUNNING_COMMAND_TIMEOUT=30

# Copyright (c) 2012-2013 Jonathan M. Lange <jml@mumak.net> and the undistract-me
# authors.

# The undistract-me authors are:
#  * Canonical Ltd
#  * Jonathan Lange
#  * Matthew Lefkowitz
#  * Clint Byrum
#  * Mikey Neuling
#  * Stephen Rothwell

# and are collectively referred to as "undistract-me developers".

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function get_now() {
    local secs
    if ! secs=$(printf "%(%s)T" -1 2> /dev/null) ; then
        secs=$(\date +'%s')
    fi
    echo $secs
}

function sec_to_human () {
    local H=''
    local M=''
    local S=''

    local h=$(($1 / 3600))
    [ $h -gt 0 ] && H="${h} hour" && [ $h -gt 1 ] && H="${H}s"

    local m=$((($1 / 60) % 60))
    [ $m -gt 0 ] && M=" ${m} min" && [ $m -gt 1 ] && M="${M}s"

    local s=$(($1 % 60))
    [ $s -gt 0 ] && S=" ${s} sec" && [ $s -gt 1 ] && S="${S}s"

    echo $H$M$S
}

function precmd () {
  path_expand='%~'
  print -Pn "\e]0;${path_expand}\a"

  if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
    #async for speed
    (nvr -c "silent lcd $PWD" &)
  fi

  if [[ -n "$__udm_last_command_started" ]]; then

    now=$(get_now)
      local time_taken=$(( $now - $__udm_last_command_started ))
      local time_taken_human=$(sec_to_human $time_taken)
      local appname=$(basename "${__udm_last_command%% *}")
      if [[ $time_taken -gt $LONG_RUNNING_COMMAND_TIMEOUT ]] &&
        [[ -n $DISPLAY ]] &&
        [[ ! " $LONG_RUNNING_IGNORE_LIST " == *" $appname "* ]] ; then
        local icon=dialog-information
        local urgency=low
        if [[ $__preexec_exit_status != 0 ]]; then
          icon=dialog-error
          urgency=normal
        fi
        notify=$(command -v notify-send)
        if [ -x "$notify" ]; then
          $notify \
          -i $icon \
          -u $urgency \
          "Command completed in $time_taken_human" \
          "$__udm_last_command"
        else
          echo -ne "\a"
        fi
      fi
      if [[ -n $LONG_RUNNING_COMMAND_CUSTOM_TIMEOUT ]] &&
        [[ -n $LONG_RUNNING_COMMAND_CUSTOM ]] &&
        [[ $time_taken -gt $LONG_RUNNING_COMMAND_CUSTOM_TIMEOUT ]] &&
        [[ ! " $LONG_RUNNING_IGNORE_LIST " == *" $appname "* ]] ; then
        # put in brackets to make it quiet
        export __preexec_exit_status
        ( $LONG_RUNNING_COMMAND_CUSTOM \
          "\"$__udm_last_command\" took $time_taken_human" & )
      fi
  fi
}

function preexec () {
  __udm_last_command=$(echo "$1")
  path_expand='%~:'

  print -Pn "\e]0;${path_expand}${__udm_last_command}\a"
  # use __udm to avoid global name conflicts
  __udm_last_command_started=$(get_now)
}
#}}}

# vim: set fdm=marker:

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

#zplug {{{
if [ -f ~/.zplug/init.zsh ]; then
  source ~/.zplug/init.zsh

  # zplug 'zsh-users/zsh-autosuggestions'
  zplug 'urbainvaes/fzf-marks'
  zplug "MichaelAquilina/zsh-you-should-use"
  
  # export YSU_HARDCORE=1
fi
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
if [ -z $NO_COMPLETE ]; then
  autoload -Uz compinit
  
  #faster load, may require manual load after installs
  for dump in ~/.zcompdump(N.mh+24); do
    # Install plugins if there are plugins that have not been installed
      if [ -f ~/.zplug/init.zsh ]; then
        if ! zplug check --verbose; then
          printf "Install? [y/N]: "
          if read -q; then
            echo; zplug install
          fi
        fi
      fi

    compinit
  done
  
  if [ -f ~/.zplug/init.zsh ]; then
    zplug load
  fi

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
else
  export COMPLETE_DISABLED="true"
fi
#}}}

#aliases {{{
#ls {{{
alias cs='cd'
alias l='exa'
alias ls='exa'
alias sl='exa'
alias ll='exa -l'
alias la='exa -a'
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
alias calc='insect'
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
alias ffi="$FZF_DEFAULT_COMMAND"
alias fdi="$FZF_DIR_COMMAND"

alias h='history'

alias s="du -hs * .[^.]* 2> /dev/null | sort -h"

alias rf="rm -rf"
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

#cargo fix HACK {{{
alias start_cargo='mv ~/.gitconfig ~/.gitconfig.bak'
alias end_cargo='mv ~/.gitconfig.bak ~/.gitconfig'
alias c-update='cargo install-update -a'
#}}}
#}}}

#nvim terminal specific settings {{{
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  export NVIM_BUF_ID=$(nvr --remote-expr "bufnr('%')")
  alias h='nvr -o'
  alias v='nvr -O'
  alias t='nvr --remote-tab'
  alias e='nvr --remote'
  export GIT_TERMINAL_PROMPT=1
  export VISUAL='nvr -cc split --remote-wait -c "set bufhidden=delete"'
  export EDITOR="$VISUAL"

  #indicate insert vs normal mode zsh
  zle-keymap-select () {
    case $KEYMAP in
      vicmd) (nvr -cc "ZshVIMModeExitInsert" &);;
      viins|main) (nvr -cc "ZshVIMModeEnterInsert" &);;
    esac
  }

  zle -N zle-keymap-select
fi
#}}}

#fzf {{{
  _fzf_compgen_path () {
    eval "$FZF_DEFAULT_COMMAND '' $1"
  }

  _fzf_compgen_dir () {
    eval "$FZF_DIR_COMMAND '' $1"
  }


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#}}}

#thefuck (lazy loading) {{{
if command -v thefuck >/dev/null 2>&1; then
  a='if type fuck_alias &>/dev/null; then; fuck_alias; else;'
  b=' eval "$(thefuck --alias fuck_alias)"; fuck_alias; fi'
  alias f="$a$b"
fi
#}}}

#prexec: handles setting path for nvim, notifications, and terminal names {{{
export LONG_RUNNING_COMMAND_TIMEOUT=4

function get_now() {
    local secs
    if ! secs=$(printf "%(%s)T" -1 2> /dev/null) ; then
        secs=$(\date +'%s')
    fi
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

function active_window_id () {
  if [[ -n $DISPLAY ]] ; then
    xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}'
    return
  fi
  echo nowindowid
}

export __udm_last_command_handled=0

function precmd () {
  path_expand='%~'
  print -Pn "\e]0;${path_expand}\a"

  if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
    (nvr -c "silent lcd $PWD" &)
    (nvr -cc "ZshVIMModeEnterInsert" &)
  fi

  if [[ -n "$__udm_last_command_started" ]]; then
    now=$(get_now)
    local focused_window=$(active_window_id)
    local time_taken=$(( $now - $__udm_last_command_started ))
    local time_taken_human=$(sec_to_human $time_taken)
    local appname=$(basename "${__udm_last_command%% *}")
    if [[ $__udm_last_command_handled == 0 ]] && 
      [[ $time_taken -gt $LONG_RUNNING_COMMAND_TIMEOUT ]] && 
      [[ ! " $LONG_RUNNING_IGNORE_LIST " == *" $appname "* ]]; then 
      if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
        local nvim_current_buffer=$(nvr --remote-expr "bufnr('%')" 2> /dev/null)
      fi
      if [[ $focused_window != $__udm_last_window ]] || 
        [[  $nvim_current_buffer != $NVIM_BUF_ID ]]; then
        local icon=dialog-information
        local urgency=low
        if [[ $__preexec_exit_status != 0 ]]; then
          icon=dialog-error
          urgency=normal
        fi
        notify=$(command -v notify-send)
        if [ -x "$notify" ]; then
          echo $time_taken
          $notify -i $icon -u $urgency "$time_taken_human:" \
            "$__udm_last_command"
        else
          echo -ne "\a"
        fi
      fi
    fi
    __udm_last_command_handled=1
  fi
}

function preexec () {
  __udm_last_command=$(echo "$1")
  __udm_last_window=$(active_window_id)
  path_expand='%~:'

  print -Pn "\e]0;${path_expand}${__udm_last_command}\a"
  # use __udm to avoid global name conflicts
  __udm_last_command_started=$(get_now)
  __udm_last_command_handled=0
}
#}}}

unset zle_bracketed_paste

# vim: set fdm=marker:

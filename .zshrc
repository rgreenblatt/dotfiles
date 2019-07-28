#setup {{{1
if [ -z "$CONFIG_HOME" ]; then
  if [ -n "$SSHHOME" ]; then
    CONFIG_HOME=$SSHHOME
  else
    CONFIG_HOME=$HOME
  fi
  export CONFIG_HOME
fi

export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

source $CONFIG_HOME/.shellrc

#prompt {{{1
autoload -Uz promptinit
promptinit
prompt ryan black blue green yellow

#bindings {{{1
bindkey -v

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

export KEYTIMEOUT=1

#zgen {{{1
if [ -f ~/.zgen/zgen.zsh ]; then
  source ~/.zgen/zgen.zsh

  zgen_make_save() {
    echo "creating zgen save"

    zgen oh-my-zsh plugins/dircycle
    zgen oh-my-zsh plugins/dirpersist
    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/fancy-ctrl-z
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/ubuntu
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/cargo
    zgen oh-my-zsh plugins/ripgrep

    zgen loadall <<EOPLUGINS
    zsh-users/zsh-autosuggestions
    webyneter/docker-aliases
    urbainvaes/fzf-marks
    MichaelAquilina/zsh-you-should-use
    mollifier/cd-gitroot
    hschne/fzf-git
    zpm-zsh/ssh
EOPLUGINS
    zgen save
  }

  if ! zgen saved; then
    zgen_make_save
  fi
  bindkey '' insert-cycledleft
  bindkey '' insert-cycledright
  alias cdg='cd-gitroot'
fi

#history {{{1
setopt histignorealldups

#completion {{{1
if [ -z $NO_COMPLETE ]; then
  autoload -Uz compinit
  
  #faster load, may require manual load after installs
  for dump in ~/.zcompdump(N.mh+24); do
    # Install plugins if there are plugins that have not been installed
    compinit
  done
  
  compinit -C
  zstyle ':completion:*' auto-description 'specify: %d'
  zstyle ':completion:*' completer _expand _complete _correct _approximate
  zstyle ':completion:*' format 'Completing %d'
  # zstyle ':completion:*' group-name ''
  zstyle ':completion:*' menu select=2
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
  zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
  zstyle ':completion:*' menu select=long
  zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
  # zstyle ':completion:*' use-compctl false
  zstyle ':completion:*' verbose true

  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
  zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

  setopt rm_star_silent
  setopt +o nomatch

  #I am not convinced these lines do anything
  zstyle ':completion:*:(scp|rsync):*' tag-order \
    ' hosts:-ipaddr:ip\ address hosts:-host:host files'
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns \
    '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns \
    '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' \
    '255.255.255.255' '::1' 'fe80::*'

  compdef sshrc=ssh
else
  export COMPLETE_DISABLED="true"
fi

#zsh specific aliases {{{1
#see https://github.com/zimfw/zimfw/tree/master/modules/git for git aliases

alias -g H='| head'
alias -g T='| tail'
alias -g L="| bat"
alias -g F="| fzf"
alias -g NO="> /dev/null"
alias -g NE="2> /dev/null"
alias -g NA="&> /dev/null"

#nvim terminal specific settings {{{1
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  NVIM_BUF_ID=$(nvr --remote-expr "bufnr('%')")
  export NVIM_BUF_ID
  alias h='nvr -o'
  alias v='nvr -O'
  alias t='nvr --remote-tab'
  alias e='nvr'
  export GIT_TERMINAL_PROMPT=1
  export VISUAL='nvr -cc split --remote-wait -c "set bufhidden=delete"'
  export EDITOR="$VISUAL"
  export SUDO_EDITOR="$VISUAL"

  #indicate insert vs normal mode zsh
  zle-keymap-select() {
    case $KEYMAP in
    vicmd) (nvr -cc "ZshVIMModeExitInsert" &) ;;
    viins | main) (nvr -cc "ZshVIMModeEnterInsert" &) ;;
    esac
  }

  zle -N zle-keymap-select
fi

#fzf setup {{{1
_fzf_compgen_path() {
  eval "$FZF_DEFAULT_COMMAND '' $1"
}

_fzf_compgen_dir() {
  eval "$FZF_DIR_COMMAND '' $1"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#prexec: handles setting path for nvim, notifications, and terminal names {{{1
export LONG_RUNNING_COMMAND_TIMEOUT=30

function get_now() {
  local secs
  if ! secs=$(printf "%(%s)T" -1 2>/dev/null); then
    secs=$(\date +'%s')
  fi

  echo $secs
}

function sec_to_human() {
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

function active_window_id() {
  if [[ -n $DISPLAY ]]; then
    xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}'
    return
  fi

  echo nowindowid
}

export __udm_last_command_handled=0

function precmd() {
  path_expand='%~'
  print -Pn "\e]0;${path_expand}\a"

  if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
    (nvr -c "silent lcd $PWD" &)
    (nvr -cc "ZshVIMModeEnterInsert" &)
  fi

  if [[ -n $__udm_last_command_started ]]; then
    now=$(get_now)
    local focused_window=$(active_window_id)
    local time_taken=$((now - __udm_last_command_started))
    local time_taken_human=$(sec_to_human $time_taken)
    local appname=$(basename "${__udm_last_command%% *}")
    if [[ $__udm_last_command_handled == 0 ]] &&
      [[ $time_taken -gt $LONG_RUNNING_COMMAND_TIMEOUT ]] &&
      [[ " $LONG_RUNNING_IGNORE_LIST " != *" $appname "* ]]; then
      if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
        local nvim_current_buffer=$(nvr --remote-expr "bufnr('%')" 2>/dev/null)
      fi
      if [[ $focused_window != $__udm_last_window ]] ||
        [[ $nvim_current_buffer != $NVIM_BUF_ID ]]; then
        local icon=dialog-information
        local urgency=low
        if [[ $__preexec_exit_status != 0 ]]; then
          icon=dialog-error
          urgency=normal
        fi
        notify=$(command -v notify-send)
        if [ -x "$notify" ]; then
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

function preexec() {
  __udm_last_command=$(echo "$1")
  __udm_last_window=$(active_window_id)
  path_expand='%~:'

  print -Pn "\e]0;${path_expand}${__udm_last_command}\a"
  # use __udm to avoid global name conflicts
  __udm_last_command_started=$(get_now)
  __udm_last_command_handled=0
}
#}}}

# vim: set fdm=marker:

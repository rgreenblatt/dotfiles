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

export INTERATIVE_SHELL="zsh"
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
    # zgen oh-my-zsh plugins/rust
    zgen oh-my-zsh plugins/ripgrep

    zgen loadall <<EOPLUGINS
    zsh-users/zsh-autosuggestions
    webyneter/docker-aliases
    urbainvaes/fzf-marks
    MichaelAquilina/zsh-you-should-use
    mollifier/cd-gitroot
    hschne/fzf-git
    zpm-zsh/ssh
    ziglang/shell-completions
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
  # export ZSH_CACHE_DIR=~/.cache/zsh/
else
  export COMPLETE_DISABLED="true"
fi

# language specific {{{2
if [ -t 0 ]; then
  test -r /home/ryan/.opam/opam-init/complete.zsh &&
    . /home/ryan/.opam/opam-init/complete.zsh >/dev/null 2>/dev/null || true

  test -r /home/ryan/.opam/opam-init/env_hook.zsh &&
    . /home/ryan/.opam/opam-init/env_hook.zsh >/dev/null 2>/dev/null || true
fi

#zsh specific aliases {{{1
alias pip3='noglob pip3'
alias pip='noglob pip3'
alias -g H='| head'
alias -g T='| tail'
alias -g L="| bat"
alias -g F="| fzf"
alias -g NO="> /dev/null"
alias -g NE="2> /dev/null"
alias -g NA="&> /dev/null"

#nvim terminal specific settings {{{1
has_nvim_and_has_nvr=false
if [[ -n "${NVIM_LISTEN_ADDRESS+x}" ]] && 
  hash nvr 2> /dev/null; then
  has_nvim_and_has_nvr=true
fi

if [ "$has_nvim_and_has_nvr" = true ] ; then
  NVIM_BUF_ID=$(nvr --remote-expr "bufnr('%')")
  export NVIM_BUF_ID

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

# Paste the selected alias into the command line
fzf_aliases() {
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  a="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.."
  b=" --tiebreak=index --bind=ctrl-r:toggle-sort +m"
  paste <(print -rl -- ${(k)aliases}) <(print -rl -- ${aliases}) |
    FZF_DEFAULT_OPTS="$a$b" $(__fzfcmd) | awk '{print $1;}' | writecmd
}

fzf_functions() {
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  a="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.."
  b=" --tiebreak=index --bind=ctrl-r:toggle-sort +m "
  c="--preview 'zsh -c \"NO_COMPLETE=true source ~/.zshrc && which {}\"'"
  print -rl -- ${(k)functions} | FZF_DEFAULT_OPTS="$a$b$c" $(__fzfcmd) |
    writecmd
}

fzf_variables() {
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  a="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.."
  b=" --tiebreak=index --bind=ctrl-r:toggle-sort +m "
  c="--preview 'zsh -c \"NO_COMPLETE=true source ~/.zshrc && get_value {}\"'"
  paste <(print -rl -- ${(k)parameters}) <(print -rl -- ${parameters}) |
    FZF_DEFAULT_OPTS="$a$b$c" $(__fzfcmd)
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

  if [ "$has_nvim_and_has_nvr" = true ]; then
    if [[ -d $PWD ]]; then
      (nvr -c "silent CDIfAuto $PWD" &)
    fi 
    (nvr -cc "ZshVIMModeEnterInsert" &)
  fi
  if [ -n "${SAVE_DIR_TO_PERSISTANT+x}" ]; then
    echo $PWD >! $PERSISTANT_LOC_FILE
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
      if [ "$has_nvim_and_has_nvr" = true ]; then
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

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
#         . "/opt/anaconda/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/anaconda/binh$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

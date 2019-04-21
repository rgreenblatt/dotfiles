if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt ryan black blue green yellow

setopt histignorealldups sharehistory

bindkey -v

autoload -z edit-command-line 
zle -N edit-command-line
bindkey "^E" edit-command-line

export KEYTIMEOUT=1

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

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

#changing cat
alias cat=bat

#common typos and changing ls
alias cs='cd'
alias l='exa'
alias ls='exa'
alias sl='exa'

# some more ls aliases
alias ll='exa -l'
alias lg='exa -l --git'
alias lgi='exa -l --git --git-ignore'
alias lt='exa -T'
alias lr='exa -R'

alias d_run_bind='docker run -it -v $HOME:$HOME -w $PWD'
alias d_run_w_bind='~/.d_run_w_bind.sh'
alias d_eval_2016='eval $(docker-machine env 2016)'
alias d_eval_unset='eval $(docker-machine env -u)'
alias py='python3'
alias python='python3'
alias pip='pip3'
alias o='xdg-open'
alias p='preview'
alias gst='git status'
alias gpu='git pull'
alias gad='git add'
alias calc='python3 -ic "from math import *; import numpy as np"'
a='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
alias stime="$a"
alias d="disown %"


mgs() {
  mgs_path=$(mgs_path $@)
  if [[ -n $mgs_path ]]; then
      cd $mgs_path
  fi
}

if hash scancel 2>/dev/null; then 
  alias cancel_all='scancel -u guest287'
fi 

if hash squeue 2>/dev/null; then 
  alias check='squeue -u guest287'
fi

alias mgsd='mgs -e ~ 4'

export VISUAL=nvim
export EDITOR="$VISUAL"

if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  alias h='nvr -o'
  alias v='nvr -O'
  alias t='nvr --remote-tab'
  alias vi='nvr --remote-tab'
  alias vim='nvr --remote-tab'
  alias nvim='nvr --remote-tab'
  alias e='nvr --remote'
  export GIT_TERMINAL_PROMPT=1
  export VISUAL='nvr -cc split --remote-wait'
  export EDITOR="$VISUAL"

  #indicate insert vs normal mode zsh
  zle-keymap-select () {
    case $KEYMAP in
      vicmd) nvr -cc "highlight TermCursor ctermfg=Blue guifg=Blue" --remote-send "<esc>";;
      viins|main) nvr -cc "highlight TermCursor ctermfg=Red guifg=Red" --remote-send "h<bs>";;
    esac
  }

  zle -N zle-keymap-select
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if hash thefuck 2>/dev/null; then
  eval $(thefuck --alias)
  eval $(thefuck --alias f)
  eval $(thefuck --alias FUCK)
fi

if [ -f ~/.undistract-me/long-running.bash ]; then
  source ~/.undistract-me/long-running.bash
  notify_when_long_running_commands_finish_install
  export IGNORE_WINDOW_CHECK=1
  # export LONG_RUNNING_IGNORE_LIST="o cat xdg-open git gca gc f p gp"
  export LONG_RUNNING_COMMAND_TIMEOUT=30
fi

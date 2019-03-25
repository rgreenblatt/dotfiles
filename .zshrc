#
# User configuration sourced by interactive shells
#

# Define zim location
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

#my aliases
alias d_run_bind='docker run -it -v $HOME:$HOME -w $PWD'
alias d_run_w_bind='~/.d_run_w_bind.sh'
alias d_eval_2016='eval $(docker-machine env 2016)'
alias d_eval_unset='eval $(docker-machine env -u)'
alias py='python3.6'
alias python3='python3.6'
alias python='python3.6'
alias pip3='pip3'
alias pip='pip3'
alias o='xdg-open'

mgs() {
  cd $(mgs_path $@)
}

alias mgsd='mgs -e ~'



# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

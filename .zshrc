#setup {{{1
if [ -z "$PROFILE_SOURCED" ]; then
  source ~/.profile
fi

export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

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
    
  zgen_make_save () {
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
setopt histignorealldups sharehistory

HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history

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
else
  export COMPLETE_DISABLED="true"
fi

#aliases {{{1
#ls {{{2
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

#docker {{{2
alias d_run_bind='docker run -it -v $HOME:$HOME -w $PWD'
alias d_run_w_bind='~/.d_run_w_bind.sh'
alias d_eval_2016='eval $(docker-machine env 2016)'
alias d_eval_unset='eval $(docker-machine env -u)'
alias d="docker"
alias dr="docker run"

#python {{{2
alias py='python3'
alias python='python3'
alias pip='pip3'

#generic {{{2
alias o='xdg-open'
alias p='preview'
alias e='editor'
alias se='sudoedit'
alias sr='sudo reboot'
alias calc='insect'
a='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
alias stime="$a"
alias di="disown %"
alias t='tail -f'
alias h='history'
alias to='htop'
alias si="du -hs * .[^.]* 2> /dev/null | sort -h"
alias s='ssh'
alias rf="rm -rf"
alias tf="tail -f"
alias cr="cp -r"
alias so="source"
alias sx="exec startx"

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

#git {{{2
#see https://github.com/zimfw/zimfw/tree/master/modules/git for list of aliases

mgs() {
  m_path=$(mgs_path $@) && cd $m_path 
}

alias mgsd='mgs -e ~ 4'

git_commit_all_submodules () {
  git config --file .gitmodules --get-regexp path | awk '{ print $2 }' | xargs git add 
  git commit --message="Submodule update"
}
alias gcas='git_commit_all_submodules'

#slurm {{{2
if hash scancel 2>/dev/null; then 
  alias cancel_all='scancel -u guest287'
fi 

if hash squeue 2>/dev/null; then 
  alias check='squeue -u guest287'
fi

#mounting flash drive {{{2
alias lm="lsblk"
alias am="udisksctl mount -b"

#cargo {{{2
alias c-update='cargo install-update -a'

#tar {{{2
alias onzt='tar xvf'
alias ot='tar xzvf'
create_tar() {
  name=$(basename "${@: -1}")
  tar $1 "$name.tar.gz" "${@:2}"
}
alias ct='create_tar czvf'
alias cnzt='create_tar cvf'


#ros {{{2
#locus {{{3
alias lsb="roslaunch locus_sim base.launch robots:=1 lidar:=gpu"
alias lsa="roslaunch locus_sim autonomy.launch robots:=1"
alias lsv="rosrun locus_viz sim"
alias locus_source_base="source /opt/locusrobotics/hotdog/dev/ros1/setup.zsh"

#general {{{3
alias r="ros"

alias rbag="rosbag"
alias rc="roscore"
alias rdi="rosdiagnostic"
alias rgr="rosgraph"
alias rn="rosnode"
alias rp="rosparam"
alias rs="rosservice"
alias rt="rostopic"
alias rw="roswtf"

source ~/.fzf_ros/fzf_ros.sh

alias rcd="roscd"
alias rcdf="fzf_roscd"

alias rl="roslaunch"
alias rlf="fzf_roslaunch"

alias rr="rosrun"
alias rrf="fzf_rosrun"

alias rte="rostopic echo"
alias rtef="fzf_ros_topic_echo"

alias rti="rostopic info"
alias rtif="fzf_ros_topic_info"

alias rne="rosnode info"
alias rnef="fzf_ros_node_info"

alias rnp="rosnode ping"
alias rnpf="fzf_ros_node_ping"

alias rnk="rosnode kill"
alias rnkf="fzf_ros_node_kill"

alias cb="catkin build"
alias cbf="fzf_catkin_build_immediate"
alias cbef="fzf_catkin_build_edit"

catkin_full_make_package() {
  catkin build $1
  catkin build roslint_$1
  catkin build run_tests_$1
}

alias cfmp="catkin_full_make_package"

alias rclf="fzf_ros_clean"

alias rse='file=$(fd setup.zsh | fzf) && source $file'

ros_link_compile_commands_json() {
  for file in $(catkin locate -b)/*
  do
    f_basename="$(basename $file)"
    if [ $f_basename != "catkin_tools_prebuild" ]; then
      src_path="$(catkin locate -s)"
      f_path=$(fd -t f -F -p "$f_basename/package.xml" "$src_path" | head -n 1)
      d_path=$(dirname "$f_path")
      ln -sf "$file/compile_commands.json" "$d_path"
    fi
  done
}
alias rlccj='ros_link_compile_commands_json'

#nvim terminal specific settings {{{1
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  export NVIM_BUF_ID=$(nvr --remote-expr "bufnr('%')")
  alias h='nvr -o'
  alias v='nvr -O'
  alias t='nvr --remote-tab'
  alias e='nvr'
  export GIT_TERMINAL_PROMPT=1
  export VISUAL='nvr -cc split --remote-wait -c "set bufhidden=delete"'
  export EDITOR="$VISUAL"
  export SUDO_EDITOR="$VISUAL"

  #indicate insert vs normal mode zsh
  zle-keymap-select () {
    case $KEYMAP in
      vicmd) (nvr -cc "ZshVIMModeExitInsert" &);;
      viins|main) (nvr -cc "ZshVIMModeEnterInsert" &);;
    esac
  }

  zle -N zle-keymap-select
fi

#source ros setup to ensure tab completion works {{{1
if [ -n "${ROS_VERSION+x}" ]; then
  source "$(cut -d':' -f1 <<< $CMAKE_PREFIX_PATH)/setup.zsh"
fi

#fzf {{{1
  _fzf_compgen_path () {
    eval "$FZF_DEFAULT_COMMAND '' $1"
  }

  _fzf_compgen_dir () {
    eval "$FZF_DIR_COMMAND '' $1"
  }


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
gsf() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# checkout git branch (including remote branches)
gcobrf() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# checkout git branch/tag
gcof() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# checkout git commit
gcocf() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# get git commit sha
# example usage: git rebase -i `gcsf`
gcsf() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}


# cd to selected parent directory
cdp() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf --tac)
  cd "$DIR"
}

# cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

#thefuck (lazy loading) {{{1
if command -v thefuck >/dev/null 2>&1; then
  a='if type fuck_alias &>/dev/null; then; fuck_alias; else;'
  b=' eval "$(thefuck --alias fuck_alias)"; fuck_alias; fi'
  alias f="$a$b"
fi

#prexec: handles setting path for nvim, notifications, and terminal names {{{1
export LONG_RUNNING_COMMAND_TIMEOUT=30

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

unset zle_bracketed_paste
#}}}

# vim: set fdm=marker:

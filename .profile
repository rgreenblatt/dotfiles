#install specific environment variables (mostly path) {{{1 
if [ -d "$HOME/bin" ] ; then #{{{2
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then #{{{2
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/scripts" ] ; then #{{{2
  export PATH="$HOME/scripts:$PATH"
fi

if [ -d "$HOME/.cargo/" ] ; then #{{{2
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.yarn" ] ; then #{{{2
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

if [ -d "$HOME/.npm-global" ] ; then #{{{2
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "/usr/local/cuda/" ]; then #{{{2
  export PATH="/usr/local/cuda/bin/:$PATH"
  # export LD_LIBRARY_PATH="/usr/local/cuda/lib64/:$LD_LIBRARY_PATH"
fi

if [ -d "/opt/intel/system_studio_2019/bin/" ] ; then #{{{2
  export PATH="/opt/intel/system_studio_2019/bin/:$PATH"
fi

if [ -d "$HOME/.nvm" ] ; then #{{{2
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# if [ -d "$HOME/athame_install" ]; then #{{{2
#   export LD_LIBRARY_PATH="$HOME/athame_install/lib/:$LD_LIBRARY_PATH"
#   export PATH="$HOME/athame_install/bin/:$PATH"
#   export SHELL="$HOME/athame_install/bin/zsh"

# fi

if [ -d "$HOME/.fzf" ] ; then #{{{1
  color00='#282828'
  color01='#3c3836'
  color02='#504945'
  color03='#665c54'
  color04='#bdae93'
  color05='#d5c4a1'
  color06='#ebdbb2'
  color07='#fbf1c7'
  color08='#fb4934'
  color09='#fe8019'
  color0A='#fabd2f'
  color0B='#b8bb26'
  color0C='#8ec07c'
  color0D='#83a598'
  color0E='#d3869b'
  color0F='#d65d0e'

  fd_base_args='--follow --hidden --exclude .git --color=always'
  export FZF_DEFAULT_COMMAND="fd $fd_base_args"
  export FZF_DIR_COMMAND="fd --type directory $fd_base_args"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DIR_COMMAND"
  
  export FZF_COMPLETION_OPTS="--preview 'preview {}' --preview-window=wrap" 
  export FZF_ALT_C_OPTS="$FZF_COMPLETION_OPTS"
  a='--preview "echo {}" --preview-window down:3:hidden:wrap'
  export FZF_CTRL_R_OPTS="$a"
  export FZF_CTRL_T_OPTS="$FZF_COMPLETION_OPTS"

  a="--layout=reverse --bind 'ctrl-s:select-all+accept,ctrl-j:jump,ctrl-k"
  b=":jump-accept,ctrl-p:toggle-preview,ctrl-w:toggle-preview-wrap,ctrl-g:top,"
  c="alt-e:execute-silent[(nvr --remote-tab {} &)]' "
  d="--color=bg+:$color01,spinner:$color0C,hl:$color0D "
  e="--color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C "
  f="--color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D --ansi"
  export FZF_DEFAULT_OPTS="$a$b$c$d$e$f"
fi

if [ -f "$HOME/.profile_machine_specific" ]; then #{{{1
  source ~/.profile_machine_specific
fi

#generic environment vars {{{1
export VISUAL=nvim
export EDITOR="$VISUAL"
export SUDO_EDITOR="$VISUAL"

export PROFILE_SOURCED=1
#}}}

# vim: set fdm=marker:

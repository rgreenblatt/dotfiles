# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/scripts" ] ; then
  export PATH="$HOME/scripts:$PATH"
fi

if [ -d "$HOME/.cargo/" ] ; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.yarn" ] ; then
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

if [ -d "$HOME/.npm-global" ] ; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "/opt/intel/system_studio_2019/bin/" ] ; then
  export PATH="/opt/intel/system_studio_2019/bin/:$PATH"
fi

if [ -d "$HOME/.nvm" ] ; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

if [ -d "$HOME/.fzf" ] ; then
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

  export FZF_DEFAULT_COMMAND='rg --files'
  a="--layout=reverse --bind ctrl-s:select-all+accept,ctrl-j:jump,ctrl-k"
  b=":jump-accept,ctrl-p:toggle-preview,ctrl-w:toggle-preview-wrap,ctrl-d"
  c=":preview-page-down,ctrl-u:preview-page-up,ctrl-g:top "
  d="--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D "
  e="--color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C "
  f="--color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
  export FZF_DEFAULT_OPTS="$a$b$c$d$e$f"
  export FZF_COMPLETION_OPTS="--preview 'preview {}' --preview-window=wrap" 
fi

if [ -f "$HOME/.profile_machine_specific" ]; then
  source ~/.profile_machine_specific
fi

export PROFILE_SOURCED=1

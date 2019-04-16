# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ "$SHELL" != "/bin/zsh" ]
then
    export SHELL="/bin/zsh"
    exec /bin/zsh -l    # -l: login shell again
fi

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
    local color00='#1d2021'
    local color01='#3c3836'
    local color02='#504945'
    local color03='#665c54'
    local color04='#bdae93'
    local color05='#d5c4a1'
    local color06='#ebdbb2'
    local color07='#fbf1c7'
    local color08='#fb4934'
    local color09='#fe8019'
    local color0A='#fabd2f'
    local color0B='#b8bb26'
    local color0C='#8ec07c'
    local color0D='#83a598'
    local color0E='#d3869b'
    local color0F='#d65d0e'

    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS="--layout=reverse --bind ctrl-a:select-all+accept,ctrl-j:jump,ctrl-k:jump-accept,ctrl-p:toggle-preview,ctrl-w:toggle-preview-wrap,ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview 'preview {}' --preview-window=wrap --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
fi

if [ -f "$HOME/.profile_machine_specific" ]; then
  source ~/.profile_machine_specific
fi

export PROFILE_SOURCED=1

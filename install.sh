#!/usr/bin/env bash

headless="false"
cronjobs="false"

targets_dir='targets'

help_msg() {
  echo "Usage:"
  echo "    ./install.sh [target]"
  echo "    available targets: $(find $targets_dir -maxdepth 1 | tr '\n' ' ')"
  echo ""
  echo "    ./install.sh -h           Display this help message."
  echo "    ./install.sh -c           Install for a headless system."
  echo "    ./install.sh -u           Enable cron jobs for update."
}

args="$*"

for var in "$@"; do
  case "$var" in
  --help)
    help_msg
    exit 0
    ;;

  *) ;;

  esac
done

# Parse options
while getopts ":hcu" opt; do
  case ${opt} in
  h)
    help_msg
    exit 0
    ;;
  c)
    echo "Installing headless"
    headless="true"
    ;;
  u)
    echo "Enabling cron jobs"
    cronjobs="true"
    ;;
  \?)
    echo "Invalid Option: -$OPTARG" 1>&2
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

echo "$args" >target

shopt -s dotglob nullglob

mkdir -p ~/.config/
mkdir -p ~/.local/etc/
mkdir -p ~/.local/bin/
mkdir -p ~/.local/share/applications

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
  curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# done before target install so profile exists
stow shell

target=$1

install_target() {
  if [[ -d "$targets_dir/$1" ]]; then
    (cd $targets_dir && stow "$1" --target ../../)
    \. ~/.profile
    extra_install_script="$1_install.sh"
    if [[ -f "$targets_dir/$extra_install_script" ]]; then
      ./$targets_dir/$extra_install_script
    fi
    echo "Installing $1"
  else
    echo "Invalid target: $1"
    exit 1
  fi
}

if [[ -n $target ]]; then
  install_target "$target"
else
  install_target default
fi

stow bat
stow cmakelint
mkdir -p ~/.config/nvim/spell/
stow nvim
stow twmn
mkdir -p ~/.config/TabNine/
stow tabnine
stow mutt
stow git
stow pylint
mkdir -p ~/.ssh
stow ssh
stow sshrc
# avoid tracking other files
mkdir -p ~/.cargo
stow rust
stow pacman
stow latex
stow gnupg
stow lldb
stow gdb
stow ranger
stow systemd

if [[ $headless == "false" ]]; then
  echo "Installing headed"
  stow compton
  stow flashfocus
  stow i3
  stow i3status
  stow misc_desktop
  stow mpv
  # by default, additional files shouldn't be tracked
  mkdir -p ~/.config/qutebrowser
  stow qutebrowser
  stow zathura
  stow xfce4-terminal
  ln -sfn "$PWD/keyboard" ~/
fi

if [ ! -d ~/.zgen ]; then
  git clone https://github.com/tarjoilija/zgen.git "$HOME/.zgen"
fi

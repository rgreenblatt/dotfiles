#!/bin/bash

headless="false"

echo "$@" >target

# Parse options
while getopts ":hc" opt; do
  case ${opt} in
  h)
    echo "Usage:"
    echo "    ./install.sh [target]"
    echo ""
    echo "    ./install.sh -h           Display this help message."
    echo "    ./install.sh -c           Install for a headless system."
    exit 0
    ;;
  c)
    echo "Installing headless"
    headless="true"
    ;;
  \?)
    echo "Invalid Option: -$OPTARG" 1>&2
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

shopt -s dotglob nullglob

git pull >/dev/null
git submodule init >/dev/null
git submodule update --recursive --remote >/dev/null

mkdir ~/.config/
mkdir -p ~/.local/etc/
mkdir ~/.local/bin/
mkdir -p ~/.local/share/applications

if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
  curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

target=$1

if [[ -n $target ]]; then
  if [[ -d $target ]]; then
    stow "$target"
    echo "Installing $target"
  else
    echo "Invalid target."
    exit 1
  fi
else
  stow generic
fi

stow bat
if [ -d "$HOME/.cargo" ]; then
  stow cargo
fi
stow cmakelint
stow nvim
stow mutt
stow shell
stow git
stow pylint
stow ssh
stow sshrc

if [[ $headless == "false" ]]; then
  echo "Installing headed"
  stow compton
  stow flashfocus
  stow i3
  stow i3status
  stow kitty
  stow misc_desktop
  stow mpv
  # by default, additional files shouldn't be tracked
  mkdir -p ~/.config/qutebrowser
  stow qutebrowser
  stow rtv
  stow st
  stow zathura
  ln -sfn "$PWD/keyboard" ~/
  reboot_job="@reboot $PWD/shell/.local/bin/cron_reboot '$PWD/shell' &"
else
  reboot_job=""
fi

c_start="#start dotfiles install DON'T DELETE THIS COMMENT"
mail="MAILTO=ryan_greenblatt@brown.edu"
install="cd $PWD && ./autoinstall.sh"
install_job="0 4 * * * $install"
c_end="#end dotfiles install DON'T DELETE THIS COMMENT"

full=$(printf '%s\n%s\n%s\n%s\n%s\n ' "$c_start" "$mail" "$reboot_job" \
  "$install_job" "$c_end")

current_cron=$(crontab -l 2>/dev/null)

line_start=$(echo "$current_cron" | grep -Fn -m 1 "$c_start" |
  grep -Eo '^[^:]+')
exit_status=$?
if [ "$exit_status" -eq 0 ]; then

  line_end=$(echo "$current_cron" | grep -Fn -m 1 "$c_end" |
    grep -Eo '^[^:]+')
  exit_status=$?
  if [ $exit_status -ne 0 ]; then
    echo >&2 "first cron tab comment found, but second wasn't found, exiting"
    exit 1
  fi
  sed_end=d
  current_cron=$(echo "$current_cron" | sed -e "$line_start,$line_end$sed_end")
else
  echo "cron jobs not found, adding"
fi

echo "$current_cron$full" | crontab -

if [ ! -d ~/.zgen ]; then
  git clone https://github.com/tarjoilija/zgen.git "$HOME/.zgen"
fi

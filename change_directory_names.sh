#!/usr/bin/env bash

if [[ -d ~/Desktop ]]; then
  mv ~/Desktop ~/desktop
fi
if [[ -d ~/Downloads ]]; then
  mv ~/Downloads ~/downloads
else
  mkdir -p ~/downloads
fi
if [[ -d ~/Templates ]]; then
  mv ~/Templates ~/templates
fi
if [[ -d ~/Public ]]; then
  mv ~/Public ~/public
fi
if [[ -d ~/Documents ]]; then
  mv ~/Documents ~/documents
else
  mkdir -p ~/documents
fi
if [[ -d ~/Music ]]; then
  mv ~/Music ~/music
fi
if [[ -d ~/Pictures ]]; then
  mv ~/Pictures ~/pictures
else
  mkdir -p ~/pictures
fi
if [[ -d ~/Videos ]]; then
  mv ~/Videos ~/videos
fi

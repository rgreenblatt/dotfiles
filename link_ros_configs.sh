#!/usr/bin/env bash

if [[ -z $1 ]]; then
  echo >&2 "workspace path must be passed"
  exit 1
fi

stow ros_configs --target $1

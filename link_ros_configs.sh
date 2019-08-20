#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  path=$1
elif [[ $# -gt 1 ]]; then
  echo >&2 "too many args passed, should just be workspace path or none"
  exit 1
elif [ -n "${ROS_WORKSPACE_PATH+x}" ]; then
  path=$ROS_WORKSPACE_PATH
else
  echo >&2 "workspace path must be passed if ROS_WORKSPACE_PATH isn't set"
  exit 1
fi

stow ros_configs --target $path

#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  path=$1
else
  echo >&2 "requires exactly one argument: path"
  exit 1
fi

cp -rTL standard_rust_configs "$path"

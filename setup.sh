#!/bin/sh

# Author: Adrien Mogenet <adrien.mogenet@gmail.com>
# Description:
#   Deploy configuration files into user's $HOME

ensure_is_linked() {
  local source=$1
  local target=$2
  test -f ${source} || (echo >&2 "file ${source} not found"; exit 2)
  test -L ${target} || (\
    echo "${target} not a symlink, installing..."
    rm -f ${target}
    ln -s ${source} ${target}
  )
}

ABS_PATH=$PWD/`dirname $0`
ensure_is_linked $ABS_PATH/git/gitconfig $HOME/.gitconfig
ensure_is_linked $ABS_PATH/bash/bashrc $HOME/.bashrc
ensure_is_linked $ABS_PATH/bash/alias $HOME/.alias
ensure_is_linked $ABS_PATH/emacs/emacs $HOME/.emacs

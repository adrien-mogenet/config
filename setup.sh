#!/bin/sh

# Author: Adrien Mogenet <adrien.mogenet@gmail.com>
# Description:
#   Deploy configuration files into user's $HOME

ensure_is_linked() {
  local source=$1
  local target=$2
  test -e $source || (echo >&2 "Resource $source not found"; exit 2)
  test -d $target && test ! -L $target && (
    echo "$target is an existing folder, will be saved.";
    mv $target ${target}-save
    )
  test -f $target && test ! -L $target && (
    echo "$target is an existing file, will be saved.";
    mv $target ${target}-save
    )
  test -L $target || (
    echo "$target not a symlink, installing...";
    ln -s $source $target
    )
  if [ -L $target ]; then
    echo "$target successfully installed."
  else
    echo >&2 "Error installing $target."
  fi
}

ABS_PATH=$PWD/`dirname $0`
ensure_is_linked $ABS_PATH/git/gitconfig $HOME/.gitconfig
ensure_is_linked $ABS_PATH/bash/bashrc $HOME/.bashrc
ensure_is_linked $ABS_PATH/bash/bash.d $HOME/.bash.d
ensure_is_linked $ABS_PATH/bash/alias $HOME/.alias
ensure_is_linked $ABS_PATH/emacs/emacs $HOME/.emacs
ensure_is_linked $ABS_PATH/emacs/emacs.d $HOME/.emacs.d
ensure_is_linked $ABS_PATH/nano/nanorc $HOME/.nanorc
ensure_is_linked $ABS_PATH/nano/nano.d $HOME/.nano.d

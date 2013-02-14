#!/bin/sh

# Author: Adrien Mogenet <adrien.mogenet@gmail.com>
# Description:
#   Deploy configuration files into user's $HOME

# Folder where we can find various *.nanorc files defining
# syntax-highlighting colors.
NANO_SYNTAX_FILES="/usr/share/nano/"

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

ensure_nano_file_included() {
  touch ~/.nano.d/includes
  local line="include \"$1\""
  if [ "`grep -c \"$line\" ~/.nano.d/includes`" == "0" ]; then
    echo "Installing $1"
    echo $line >> ~/.nano.d/includes
  fi
}

# Build the .nanorc configuration file. This is a special case because we need
# to include all the syntax-highlighting files one by one, but:
#   1. We don't want to make the original .nanorc file dirty.
#   2. Included files can't include other files itself.
# That's why the .nanorc will be copied and won't be a symlink.
build_nano_file() {
  local source=$1
  local target=$2
  rm -f $target
  for file in ${NANO_SYNTAX_FILES}/*.nanorc; do
    ensure_nano_file_included $file
  done
  cat $source ~/.nano.d/includes > $target
  rm -f ~/.nano.d/includes
}

ABS_PATH=$PWD/`dirname $0`
ensure_is_linked $ABS_PATH/git/gitconfig $HOME/.gitconfig
ensure_is_linked $ABS_PATH/bash/bashrc $HOME/.bashrc
ensure_is_linked $ABS_PATH/bash/bash.d $HOME/.bash.d
ensure_is_linked $ABS_PATH/bash/alias $HOME/.alias
ensure_is_linked $ABS_PATH/emacs/emacs $HOME/.emacs
ensure_is_linked $ABS_PATH/emacs/emacs.d $HOME/.emacs.d
ensure_is_linked $ABS_PATH/nano/nano.d $HOME/.nano.d
build_nano_file $ABS_PATH/nano/nanorc $HOME/.nanorc

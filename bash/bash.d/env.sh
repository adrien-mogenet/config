#!/bin/sh

export PATH=${PATH}:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/:/usr/local/Cellar/emacs/24.5/bin/emacs
export PATH=${PATH}:/Library/TeX/texbin
export PATH=${PATH}:/Applications/Octave.app/Contents/Resources/usr/bin/
export NAS=192.168.1.16

# This avoids adding `._foobar` files within MacOSX tarballs
export COPYFILE_DISABLE=1

source ~/.bash.d/passwords.sh
export GOPATH=/Users/adrien/Development/go/

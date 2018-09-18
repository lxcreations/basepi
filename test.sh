#!/bin/bash

INSTALLDIR=~/.basepi
INSTALLDOTS=dotfiles
INSTALLLOGS=logs
INSTALLSCRIPTS=scripts

SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )";

for sfile in $(find $SOURCEDIR/scripts/ -maxdepth 1 -name "*" -type f  -printf "%f\n" ); do
    echo "Script File: "$sfile
done

#!/bin/bash

# DEBLOAT=false
# KEY_BINDINGS=false
# PROJECT_SETUP=false
# APPLICATION_SETUP=false
# DOTFILES=false

## Check current directory
cur_dir=$(basename $PWD)
if [ "$cur_dir" != "scripts" ] ; then
	echo "You current directory should be ubuntu_setup/scripts"
	echo Bye
	exit

if ${DEBLOAT} ; then
	./debloat.sh
fi

if ${KEY_BINDINGS} ; then 
    ./keybindings.sh
fi

if ${APPLICATION_SETUP} ; then 
    ./application_setup.sh
fi

if ${DOTFILES} ; then 
    ./dotfiles.sh
fi

if ${PROJECT_SETUP} ; then 
    ./projects_setup.sh
fi










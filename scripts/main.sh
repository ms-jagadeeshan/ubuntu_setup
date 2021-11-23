#!/bin/bash

# DEBLOAT=false
# KEY_BINDINGS=false
 PROJECT_SETUP=false
# APPLICATION_SETUP=false
# DOTFILES=false

## Check current directory
cur_dir=$(basename $PWD)
if [ "$cur_dir" != "scripts" ] ; then
	echo "You current directory should be ubuntu_setup/scripts"
	echo Bye
	exit


# removes snap firefox
if ${DEBLOAT} ; then
	./debloat.sh
fi


# keybindings setup
if ${KEY_BINDINGS} ; then 
    ./keybindings.sh
fi


# application or utility i use
if ${APPLICATION_SETUP} ; then 
    ./application_setup.sh
fi

# Dotfiles like .bashrc .aliases etc.. setup
if ${DOTFILES} ; then 
    ./dotfiles.sh
fi

# my personal project directory setup
if ${PROJECT_SETUP} ; then 
    ./projects_setup.sh
fi










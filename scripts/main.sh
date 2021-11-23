#!/bin/bash

## Sourcing config
. ./config

## Check current directory
cur_dir=$(basename $PWD)
if [ "$cur_dir" != "scripts" ]; then
	echo "You current directory should be ubuntu_setup/scripts"
	echo Bye
	exit

fi

if $RUN_DEBLOAT; then
	./debloat.sh
fi

if $KEYBINDINGS_SETUP; then
	./keybindings.sh
fi

if $APPLICATION_SETUP; then
	./application_setup.sh
fi

if $DOTFILES_SETUP; then
	./dotfiles.sh
fi

if $PROJECTS_SETUP; then
	./projects_setup.sh
fi

if $RUN_HOST; then
	./hosts.sh
fi

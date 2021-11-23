#!/bin/bash

## Check current directory
cur_dir=$(basename $PWD)
if [ "$cur_dir" != "scripts" ] ; then
	echo "You current directory should be ubuntu_setup/scripts"
	echo Bye
	exit

fi

./debloat.sh
./keybindings.sh
./application_setup.sh
./dotfiles.sh
# ./projects_setup.sh
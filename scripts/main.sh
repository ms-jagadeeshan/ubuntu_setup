#!/bin/bash

## Sourcing config
. ./config
. ./functions.sh

## Check current directory
cur_dir=$(basename $PWD)
if [ "$cur_dir" != "scripts" ]; then
	echo "You current directory should be ubuntu_setup/scripts"
	echo Bye
	exit

fi

case "$1" in
-i)
	scripts=('debloat.sh' 'keybindings.sh' 'application_setup.sh' 'dotfiles.sh' 'projects_setup.sh' 'hosts.sh' 'gnome_extensions_setup.sh')
	scripts_bool=(1 0 1 1 0 1 1)
	options_str=""
	options_bool=""
	for script in "${scripts[@]}"; do
		options_str+="${script};"
	done
	for script_bool in "${scripts_bool[@]}"; do
		options_bool+="${script_bool};"
	done

	multiChoice "Select scripts to run:" result "${options_str}" "${options_bool}"
	echo results ${result[@]}
	for i in "${result[@]}"; do
		echo execting "${scripts[i]}"
		./${scripts[i]}
	done
	exit 0
	;;

*) ;;

esac

if ${RUN_DEBLOAT}; then
	./debloat.sh
fi

if ${KEYBINDINGS_SETUP}; then
	./keybindings.sh
fi

if ${APPLICATION_SETUP}; then
	./application_setup.sh
fi

if ${DOTFILES_SETUP}; then
	./dotfiles.sh
fi

if ${PROJECTS_SETUP}; then
	./projects_setup.sh
fi

if ${RUN_HOST}; then
	./hosts.sh
fi

if ${GNOME_EXTENSION_SETUP}; then
	./gnome_extensions_setup.sh
fi

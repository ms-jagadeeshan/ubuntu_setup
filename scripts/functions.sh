#!/bin/bash

## Colours and font styles
## Syntax: echo -e "${FOREGROUND_COLOUR}${BACKGROUND_COLOUR}${STYLE}Hello world!${RESET_ALL}"

# Escape sequence and resets
ESC_SEQ="\x1b["
RESET_ALL="${ESC_SEQ}0m"
RESET_BOLD="${ESC_SEQ}21m"
RESET_UL="${ESC_SEQ}24m"

# Foreground colours
FG_BLACK="${ESC_SEQ}30m"
FG_RED="${ESC_SEQ}31m"
FG_GREEN="${ESC_SEQ}32m"
FG_YELLOW="${ESC_SEQ}33m"
FG_BLUE="${ESC_SEQ}34m"
FG_MAGENTA="${ESC_SEQ}35m"
FG_CYAN="${ESC_SEQ}36m"
FG_WHITE="${ESC_SEQ}37m"
FG_BR_BLACK="${ESC_SEQ}90m"
FG_BR_RED="${ESC_SEQ}91m"
FG_BR_GREEN="${ESC_SEQ}92m"
FG_BR_YELLOW="${ESC_SEQ}93m"
FG_BR_BLUE="${ESC_SEQ}94m"
FG_BR_MAGENTA="${ESC_SEQ}95m"
FG_BR_CYAN="${ESC_SEQ}96m"
FG_BR_WHITE="${ESC_SEQ}97m"

# Background colours (optional)
BG_BLACK="40m"
BG_RED="41m"
BG_GREEN="42m"
BG_YELLOW="43m"
BG_BLUE="44m"
BG_MAGENTA="45m"
BG_CYAN="46m"
BG_WHITE="47m"

# Font styles
FS_REG="0m"
FS_BOLD="1m"
FS_UL="4m"

echo_color() {
    case $1 in
    -r | --red)
        tput setaf 1
        shift
        echo $@
        ;;
    -g | --green)
        tput setaf 2
        shift
        echo $@
        ;;
    -y | --yellow)
        tput setaf 3
        shift
        echo $@
        ;;
    -b | --blue)
        tput setaf 4
        shift
        echo $@
        ;;
    *) ;;

    esac
    tput sgr0
}

# Usage: multiChoice "header message" resultArray "comma separated options" "comma separated default values"
# Credit: https://serverfault.com/a/949806
function multiChoice {
	echo "${1}"; shift
	echo "$(tput dim)""- Change Option: [up/down], Change Selection: [space], Done: [ENTER]" "$(tput sgr0)"
	# little helpers for terminal print control and key input
	ESC=$( printf "\033")
	cursor_blink_on()   { printf "%s" "${ESC}[?25h"; }
	cursor_blink_off()  { printf "%s" "${ESC}[?25l"; }
	cursor_to()         { printf "%s" "${ESC}[$1;${2:-1}H"; }
	print_inactive()    { printf "%s   %s " "$2" "$1"; }
	print_active()      { printf "%s  ${ESC}[7m $1 ${ESC}[27m" "$2"; }
	get_cursor_row()    { IFS=';' read -rsdR -p $'\E[6n' ROW COL; echo "${ROW#*[}"; }
	key_input()         {
		local key
		IFS= read -rsn1 key 2>/dev/null >&2
		if [[ $key = ""      ]]; then echo enter; fi;
		if [[ $key = $'\x20' ]]; then echo space; fi;
		if [[ $key = $'\x1b' ]]; then
			read -rsn2 key
			if [[ $key = [A ]]; then echo up;    fi;
			if [[ $key = [B ]]; then echo down;  fi;
		fi
	}
	toggle_option()    {
		local arr_name=$1
		eval "local arr=(\"\${${arr_name}[@]}\")"
		local option=$2
		if [[ ${arr[option]} == 1 ]]; then
			arr[option]=0
		else
			arr[option]=1
		fi
		eval "$arr_name"='("${arr[@]}")'
	}

	local retval=$1
	local options
	local defaults

	IFS=';' read -r -a options <<< "$2"
	if [[ -z $3 ]]; then
		defaults=()
	else
		IFS=';' read -r -a defaults <<< "$3"
	fi

	local selected=()

	for ((i=0; i<${#options[@]}; i++)); do
		selected+=("${defaults[i]}")
		printf "\n"
	done

	# determine current screen position for overwriting the options
	local lastrow
	lastrow=$(get_cursor_row)
	local startrow=$((lastrow - ${#options[@]}))

	# ensure cursor and input echoing back on upon a ctrl+c during read -s
	trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
	cursor_blink_off

	local active=0
	while true; do
		# print options by overwriting the last lines
		local idx=0
		for option in "${options[@]}"; do
			local prefix="[ ]"
			if [[ ${selected[idx]} == 1 ]]; then
				prefix="[x]"
			fi

			cursor_to $((startrow + idx))
			if [ $idx -eq $active ]; then
				print_active "$option" "$prefix"
			else
				print_inactive "$option" "$prefix"
			fi
			((idx++))
		done

		# user key control
		case $(key_input) in
			space)  toggle_option selected $active;;
			enter)  break;;
			up)     ((active--));
				if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
			down)   ((active++));
				if [ "$active" -ge ${#options[@]} ]; then active=0; fi;;
		esac
	done

	# cursor position back to normal
	cursor_to "$lastrow"
	printf "\n"
	cursor_blink_on

	indices=()
	for((i=0;i<${#selected[@]};i++)); do
		if ((selected[i] == 1)); then
			indices+=("${i}")
		fi
	done

	# eval $retval='("${selected[@]}")'
	eval "$retval"='("${indices[@]}")'
}
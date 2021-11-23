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

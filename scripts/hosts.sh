#!/bin/bash

links=(
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/social/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-porn/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-social/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-social/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn-social/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-porn-social/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn-social/hosts'
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts'
)

case $1 in
-i)
    echo -e "\
 1)Unified hosts = (adware +malware)
 2)Unified hosts + fakenews
 3)Unified hosts + gambling
 4)Unified hosts + porn
 5)Unified hosts + social
 6)Unified hosts + fakenews + gambling
 7)Unified hosts + fakenews + porn
 8)Unified hosts + fakenews + social
 9)Unified hsots + gambling + porn
10)Unified hosts + gambling + social
11)Unified hosts + porn + social
12)Unified hosts + fakenews + gambling + porn
13)Unified hosts + fakenews + gambling + social
14)Unified hosts + fakenews + porn + social
15))Unified hosts + fakenews + gambling + porn + social"
    printf "Choose Your option(1-15): "
    read choice
    ;;
-n)
    choice="$2"
    ;;

*)
    . ./config
    choice="${HOST_OPTION:-12}"
    ;;
esac

case $choice in
1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15)
    sudo wget ${links[((choice -= 1))]} -O /etc/hosts
    ;;
*)
    echo "Enter valid choice"
    exit 1
    ;;
esac

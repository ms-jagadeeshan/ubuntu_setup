#!/bin/bash

echo_color -y "Romoving snap firefox, if exists...."
sudo snap remove --purge firefox
sudo rm -rf /var/cache/snapd/

echo_color -y "Uninstalling snapd and gnome-software-plugin-snap...."
sudo apt autoremove -y --purge snapd gnome-software-plugin-snap
rm -fr ~/snap

sudo apt-mark hold snapd

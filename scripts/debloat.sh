sudo snap remove --purge firefox
sudo rm -rf /var/cache/snapd/
sudo apt autoremove -y  --purge snapd gnome-software-plugin-snap
rm -fr ~/snap
sudo apt-mark hold snapd
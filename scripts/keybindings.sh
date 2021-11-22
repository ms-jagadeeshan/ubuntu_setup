#!/bin/bash


#sets key Binding
function setKeybBinding()
{
    create_key_text="set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom"
    args=("$@")
    echo "${create_key_text}${args[4]}"/ name \"${args[0]}\" | xargs gsettings
    echo "${create_key_text}${args[4]}"/ command \"${args[1]}\" | xargs gsettings
    echo "${create_key_text}${args[4]}"/ binding \"${args[2]}\" | xargs gsettings
}

function initKeyBinding()
{
    create_key_text="set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom"
    text="['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/'"
    for((i=1;i<10;i++));do
        text="${text},'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/'"
    done

    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${text}]"
}

#initializes key binding schema
initKeyBinding

#key binding 1
wifi_toggle=( 'Wifi Toggle' 'sh -c '"'"'[ $(nmcli radio wifi) = "enabled" ] && nmcli radio wifi off || (nmcli radio wifi on && sleep .1 && nmcli device wifi hotspot con-name myhotspot ssid turing-machine password Jaga@123)'"'"'' "<Alt>w" "0")

setKeyBinding "${wifi_toggle[@]}"

cust_key_output=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)


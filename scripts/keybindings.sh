#!/bin/bash

#sets key Binding
function setKeybBinding()
{
    ### Example ### 
    ### $ set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0 name 'Name_of_keybinding'
    ### $ set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0 command 'command_to_execute'
    ### $ set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0 binding '<Alt>w' 
    create_key_text="set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom"
    args=("$@")
    echo "${create_key_text}${args[4]}"/ name \"${args[0]}\" | xargs gsettings
    echo "${create_key_text}${args[4]}"/ command \"${args[1]}\" | xargs gsettings
    echo "${create_key_text}${args[4]}"/ binding \"${args[2]}\" | xargs gsettings
}

### Warning : This may overwrite existing keybinding
function initKeyBinding()
{
    ### Example ###
    ### This will create one schema location
    ### $ gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']
    ### 
    ### To create many schemas, put custom0, custom1 like that
    ### $ gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']
    text="['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/'"
    for((i=1;i<10;i++));do
        text="${text},'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/'"
    done
    
    ### creating 10 schema location(10 custom keybindings)
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${text}]"
}

### initializes key binding schema
initKeyBinding

### Syntax: array=( 'name_of_keybinding' 'command_to_execute' 'keybinding' 'integer')
### integer is used as the custom<integer>
### key binding 1
wifi_toggle=( 'Wifi Toggle' 'sh -c '"'"'[ $(nmcli radio wifi) = "enabled" ] && nmcli radio wifi off || (nmcli radio wifi on && sleep .1 && nmcli device wifi hotspot con-name myhotspot ssid turing-machine password Jaga@123)'"'"'' "<Alt>w" "0")

setKeyBinding "${wifi_toggle[@]}"

# cust_key_output=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)


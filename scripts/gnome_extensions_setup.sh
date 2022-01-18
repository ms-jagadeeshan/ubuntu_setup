#!/bin/bash

set -x -e
extension_list=(
    'https://extensions.gnome.org/extension-data/netspeedhedayaty.gmail.com.v33.shell-extension.zip'

)

gnome-ext-install() {
    # Verify that the first parameter is an existing file with the ".zip" extension
    if [ ! -f $1 ] || [ "${1: -4}" != ".zip" ]; then
        echo "Usage: gnome-ext-install <zip-file>"
        echo "[ERROR] No existing ZIP-file specified as a parameter."
        exit 1
    fi

    # Make sure the "jq" tool is installed on the system.
    if [ ! -x "$(command -v jq)" ]; then
        echo "[ERROR] jq is not installed on your system. Install with:"
        echo "  * sudo apt install jq (Ubuntu/Debian)"
        echo "  * sudo dnf install jq (Fedora)"
        echo "  * sudo zypper install jq (openSUSE)"
        exit 1
    fi

    # Make sure the directory for storing the user's shell extension exists.
    mkdir -p ~/.local/share/gnome-shell/extensions/

    # Extract JSON "uuid" variable value from "metadata.json" in the ZIP-file.
    MY_EXT_UUID=$(unzip -p $1 metadata.json | jq -r '.uuid')

    # Check that variable is set to a non-empty string
    if [ -z "${MY_EXT_UUID}" ]; then
        echo "[ERROR] Could not extract the UUID from metadata.json in the ZIP-file."
        exit 1
    fi

    # Extract the ZIP-file to a subdirectory with the same name as the "uuid".
    unzip -q -o $1 -d ~/.local/share/gnome-shell/extensions/$MY_EXT_UUID
    sleep 2
    gnome-extensions enable $MY_EXT_UUID
    # Restart Gnome Shell to activate the Gnome Shell extension.
    # busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")' > /dev/null 2>&1

    echo "Gnome Shell Extension installed in ~/.local/share/gnome-shell/extensions/$MY_EXT_UUID/"
}

function checkOS() {
    if [[ -e /etc/debian_version ]]; then
        OS="debian"
        source /etc/os-release

        if [[ $ID == "debian" || $ID == "raspbian" ]]; then
            OS="debian"
        elif [[ $ID == "ubuntu" ]]; then
            OS="ubuntu"
        fi
    elif [[ -e /etc/system-release ]]; then
        source /etc/os-release
        if [[ $ID == "fedora" || $ID_LIKE == "fedora" ]]; then
            OS="fedora"
        fi
        if [[ $ID == "centos" || $ID == "rocky" || $ID == "almalinux" ]]; then
            OS="centos"
        fi
    elif [[ -e /etc/arch-release ]]; then
        OS="arch"
    else
        echo "Looks like you aren't running this installer on a Debian, Ubuntu, Fedora, CentOS, or Arch Linux system"
        exit 1
    fi
}
function install_jq() {
    case "${OS}" in
    "ubuntu" | "debian")
        sudo apt install -y jq
        ;;
    "fedora")
        sudo dnf install -y jq
        ;;
    "centos")
        sudo yum install jq -y
        ;;
    *)
        echo "default (none of above)"
        ;;
    esac
}

checkOS
install_jq

TEMP_DIR="${HOME}/tmp"
mkdir -p ${TEMP_DIR}
pushd ${TEMP_DIR} >/dev/null
for extension in "${extension_list[@]}"; do
    wget ${extension_list[0]}
    gnome-ext-install $(basename ${extension_list[0]})
done
popd >/dev/null

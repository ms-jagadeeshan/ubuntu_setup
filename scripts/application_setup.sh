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

# Uncomment it if you don't want to install
INSTALL_VSCODE=false
INSTALL_STREMIO=false
INSTALL_CLOUDFARE=false
INSTALL_GO_COMPILER=false
INSTALL_TEAMS=false
INSTALL_TELEGRAM=false
INSTALL_XMRIG=false
INSTALL_MONERO_WALLET=false
INSTALL_WATERFOX=false

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

install_waterfox() {
    if [ ! -d "~/Downloads" ]; then
        mkdir -p ~/Downloads
    fi
    pushd ~/Downloads
    echo_color -y "Downloading waterfox tar archive"
    wget -qO- https://github.com/WaterfoxCo/Waterfox/releases/download/G4.0.2.1/waterfox-G4.0.2.1.en-US.linux-x86_64.tar.bz2 | sudo tar -xj -C '/usr/local/bin/'
    sudo chmod +x /usr/local/bin/waterfox/waterfox
    if [ ! -d "${HOME}/.local/share/applications" ]; then
        mkdir -p "${HOME}/.local/share/applications"
    fi
    echo '[Desktop Entry]
Version=1.0
Name=Waterfox
Comment=Browse the World Wide Web
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Terminal=false
Type=Application
Icon=/usr/local/bin/waterfox/browser/chrome/icons/default/default64.png
Exec="/usr/local/bin/waterfox/waterfox"
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true' | tee $HOME/.local/share/applications/waterfox.desktop >/dev/null
    echo_color -y "Desktop shortcut created!!"
    popd
}

install_vscode() {
    echo_color -y "Downloading gpg keys..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    echo_color -y "Installing keys to /etc/apt/trusted.gpg.d/"
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    sudo apt-get update && echo_color -y "Installing VS code...." && sudo apt-get install -y code
}

install_monero_wallet() {

    mkdir -p ~/app_builds
    pushd ~/app_builds
    wget -qO- https://downloads.getmonero.org/gui/linux64 | tar -xj
    popd
}

install_go_compiler() {
    cd ~/Downloads
    echo_color -b "Downloading Go Binary files"
    wget -q 'https://golang.org/dl/go1.17.3.linux-amd64.tar.gz'
    echo_color -b"Installing go to /usr/local"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.3.linux-amd64.tar.gz
    rm -v go*linux-amd64.tar.gz
    echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.bashrc
    popd
}

install_xmrig() {
    echo_color -y "Installing git,build-essential,cmake,libuv-1-dev,libssl-dev,libhwloc-dev"
    sudo apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
    mkdir -p ~/app_builds
    pushd ~/app_builds
    git clone https://github.com/xmrig/xmrig.git
    mkdir xmrig/build && pushd xmrig/build
    cmake ..
    make $(nproc)
    echo_color -g "xmrig compiled!!"
    popd
    popd
}

install_telegram() {
    pushd ~/Downloads
    echo_color -y "Downloading Telegram appimage tar file"
    wget -q 'https://telegram.org/dl/desktop/linux' -O - | tar -xJ
    echo_color -y "Telegram appimage downloaded to ~/Downloads"
    popd

}

install_noisetorch() {
    pushd ~/Downloads
    echo_color -b "Downloading NoiseTorce binary tar file"
    wget -q https://github.com/lawl/NoiseTorch/releases/download/0.11.4/NoiseTorch_x64.tgz
    echo_color -b "Unpacking NoiceTorch"
    tar -C $HOME -xzf NoiseTorch_x64.tgz
    echo_color -b "Setting up permission"
    sudo setcap 'CAP_SYS_RESOURCE=+ep' ~/.local/bin/noisetorch
    rm -v NoiseTorch_x64.tgz
    popd
}

uninstall_noisetorch() {
    rm -v ~/.local/bin/noisetorch
    rm -v ~/.local/share/applications/noisetorch.desktop
    rm -v ~/.local/share/icons/hicolor/256x256/apps/noisetorch.png
}

install_deb() {
    pushd ~/Downloads
    deb_name=$(basename $1)
    echo_color -b "Downloading ${deb_name}"
    wget -q $1
    echo_color -b "Installing ${deb_name}"
    sudo dpkg -i ${deb_name}
    rm -v ${deb_name}
    popd
}

obs_wayland_support() {
    if [ ${QT_QPA_PLATFORM} = "" ]; then
        echo 'export QT_QPA_PLATFORM=wayland' >>~/.bashrc
    fi
}

kdeconnect_firewall() {
    sudo ufw allow 1714:1764/udp
    sudo ufw allow 1714:1764/tcp
    sudo ufw reload
}

# Package required for the scripts
dependencies=(

    #Don't comment any of it
    'apt-transport-https'

    'git'

    'make'

    'build-essential'

    'cmake'
    # dependencies of stremio
    'nodejs'
    'libmpv1'
    'qml-module-qtwebchannel'
    #  'libfdk-aac1'

    # chroot
    'qemu' 'qemu-user-static' 'binfmt-support'
)

# Common application and development tools
apps=(

    # Comment the apps you don't need
    'g++' # c++ compiler

    'plocate' # file searching tool , newer and faster alternative to mlocate

    #  'mlocate'

    'neovim' # popular fork of vim, and modernized vim

    'curl'

    'transmission' # popular torrent client

    'kdeconnect'

    'firefox' # web browser

    'neofetch'

    'tree' # display files in tree format

    'p7zip-full' # file archiver with high compression ratio

    'youtube-dl' # youtube downloader

    'obs-studio' # best screen recording tool

    'kdenlive' # video editing tool

    'flatpak'

    'gnome-boxes' # virtualization tool

    'traceroute' # networking tool

    'exiftool'

    'net-tools'

    'nmap'

    'mediainfo'
)

# checking whether app exists
for ((i = ${#apps[@]}; i > 0; i--)); do
    dpkg -s "${apps[$i - 1]}" &>/dev/null
    if [ $? -eq 0 ]; then
        unset apps[$((i - 1))]
    else
        # checking whether app installed
        apt-cache show "${apps[$i - i]}" &>/dev/null
        if [ $? -ne 0 ]; then
            unset apps[$((i - 1))]
        fi
    fi
done


# checking whether app exists
for ((i = ${#dependencies[@]}; i > 0; i--)); do
    dpkg -s "${dependencies[$i - 1]}" &>/dev/null
    if [ $? -eq 0 ]; then
        unset dependencies[$((i - 1))]
    else
        apt-cache show "${dependencies[$i - i]}" &>/dev/null
        if [ $? -ne 0 ]; then
            unset dependencies[$((i - 1))]
        fi
    fi
done

# Adding universe and multiverse repository
sudo apt-add-repository universe
sudo apt-add-repository multiverse

# apt update
tput setaf 3
echo "Updating Repostories...."
tput sgr0
sudo apt-get update >/dev/null

# apt upgrade
tput setaf 3
echo "Upgrading to packages...."
tput sgr0
sudo apt-get -y upgrade

# installing dependencies
tput setaf 3
echo "Installing ${dependencies[@]}"
echo -n -e ${RESET_ALL}
sudo apt-get install -y "${dependencies[@]}"

# installing apps
tput setaf 3
echo "Installing ${apps[@]}"
echo -n -e ${RESET_ALL}
sudo apt-get install -y "${apps[@]}"

#### Uncomment this if you use obs studio in wayland ####
obs_wayland_support

#### Uncomment this if you kdeconnect not detecting device  ####
kdeconnect_firewall

if ${INSTALL_VSCODE}; then
    install_vscode
fi

if ${INSTALL_STREMIO}; then
    install_deb 'http://archive.ubuntu.com/ubuntu/pool/multiverse/f/fdk-aac/libfdk-aac1_0.1.6-1_amd64.deb'
    install_deb 'https://dl.strem.io/shell-linux/v4.4.137/stremio_4.4.137-1_amd64.deb'
fi

if ${INSTALL_CLOUDFARE}; then
    install_deb 'https://pkg.cloudflareclient.com/uploads/cloudflare_warp_2021_7_0_1_amd64_71a4c3056d.deb'
fi

if ${INSTALL_GO_COMPILER}; then
    install_go_compiler
fi

if ${INSTALL_TEAMS}; then
    install_deb 'https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.7556_amd64.deb'
    sudo apt --fix-broken -y install
fi

if ${INSTALL_XMRIG}; then
    install_xmrig
fi

if ${INSTALL_MONERO_WALLET}; then
    install_monero_wallet
fi

if ${INSTALL_WATERFOX}; then
    install_waterfox
fi

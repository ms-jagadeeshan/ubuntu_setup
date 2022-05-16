#!/bin/bash
Ins="$HOME/opt"
mkdir -p $Ins
pushd ~/tmp
wget 'https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.2-stable.tar.xz' 
# https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2020.3.1.25/android-studio-2020.3.1.25-linux.tar.gz
# https://dl.google.com/android/studio/maven-google-com/stable/offline-gmaven-stable.zip
# echo "export PATH="$PATH:$Ins/flutter/bin"" > ~/.bashrc.local
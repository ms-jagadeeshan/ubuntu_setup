#!/bin/bash

mkdir -v "${HOME}/projects"
cd "${HOME}/projects"

git clone https://github.com/ms-jagadeeshan/lib.git
git clone https://github.com/ms-jagadeeshan/trif.git
git clone https://github.com/ms-jagadeeshan/google-meet-joiner.git

ln -sf $HOME/projects/useful_scripts/mkv_title_as_filename.sh $HOME/.local/bin/mkv_taf



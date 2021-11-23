#!/bin/bash

PROJECTS_DIR="${PROJECTS_DIR}"


if [ -d "${PROJECTS_DIR}" ]; then
    mkdir -v "${PROJECTS_DIR}"
fi

cd "${PROJECTS_DIR}"

if [ -d "${PROJECTS_DIR}/lib" ]; then
    git clone https://github.com/ms-jagadeeshan/lib.git
fi

if [ -d "${PROJECTS_DIR}/trif" ]; then
    git clone https://github.com/ms-jagadeeshan/trif.git
fi

if [ -d "${PROJECTS_DIR}/google-meet-joiner" ]; then
    git clone https://github.com/ms-jagadeeshan/google-meet-joiner.git
fi

if [ -f "$HOME/projects/useful_scripts/mkv_title_as_filename.sh" ]; then
    ln -sf $HOME/projects/useful_scripts/mkv_title_as_filename.sh $HOME/.local/bin/mkv_taf
fi
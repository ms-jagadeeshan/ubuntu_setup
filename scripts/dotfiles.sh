#!/bin/bash
set -x -e
## current folder should be scripts
DOT_DIR=$(realpath ${PWD}/../dotfiles)
ln -sf ${DOT_DIR}/bashrc ${HOME}/.bashrc
ln -sf ${DOT_DIR}/bash ${HOME}/.bash
ln -sf ${DOT_DIR}/bash_history ${HOME}/.bash_history
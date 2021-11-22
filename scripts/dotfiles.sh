#!/bin/bash

DOT_DIR=$(realpath ${PWD}/../dotfiles)
ln -sf ${DOT_DIR}/bashrc ~/.bashrc
ln -sf ${DOT_DIR}/bash ~/.bash
ln -sf ${DOT_DIR}/bash_history ~/.bash_history

#!/bin/bash

DIR=$(pwd)

function install_file {
    rm ~/$1
    ln -s $DIR/$1 ~/$1
}

# Install all of the dot files as symbolic links

install_file .vimrc
install_file .gitconfig
install_file .zshrc
install_file .conkyrc

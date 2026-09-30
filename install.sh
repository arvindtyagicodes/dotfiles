#!/usr/bin/env bash
ln -sf ~/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.vim/undo
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape_shifted_capslock']"

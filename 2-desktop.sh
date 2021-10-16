#!/usr/bin/env bash
#
# Script name: 2-desktop.sh
# Description: Third part of my Arch Linux installation script
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

# variables #

git clone https://aur.archlinux.org/yay
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

yay -S --needed --noconfirm - < applications.txt

#sudo systemctl enable displaylink
sudo systemctl enable sddm
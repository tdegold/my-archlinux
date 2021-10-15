#!/usr/bin/env bash
#
# Script name: 2-desktop.sh
# Description: Third part of my Arch Linux installation script
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

# variables #

git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd ..
rm -rf yay

declare -a packages=(
    terminator
    brave-bin
    typora
    multimc-bin
    jdk11-openjdk
    visual-studio-code-bin
    spotify
    noto-fonts-emoji
    displaylink
    evdi-git
    pcmanfm-qt
    vlc
    git
    xorg
    plasma-desktop
    sddm
)

for i in "${packages[@]}"
do
   yay -S $i --needed --noconfirm
done

sudo systemctl enable displaylink
sudo systemctl enable sddm
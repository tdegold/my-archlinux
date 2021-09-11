#!/usr/bin/env bash
#
# Script name: install-xfce4.sh
# Description: Script for installint the XFC4 desktop environment on Arch Linux
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

sudo timedatectl set-ntp true
sudo hwclock --systohc

################################
# Install Aura package manager #
################################
pacman -S --needed --no-confirm git 
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg -si
cd ..
rm -rf aura-bin

#######################
# Installing packages #
#######################
declare -a packagelist=(
    "xorg" # xorg
    "xorg-xinit" # xorg
    "xfce4" # xfce
    "xfce4-pulseaudio-plugin" # xfce
    "xfce4-notifyd" # xfce
    "arc-gtk-theme" # theme
    "arc-icon-theme" # theme
)
oneline="${packagelist[*]}"
sudo pacman -S --needed --no-confirm $oneline

###########################
# Installing packages AUR #
###########################
declare -a packagelistaur=(
    "brave-bin" # browser
    "spotify" # music
    "typora" # markdown editor
    "vscodium-bin" # gui-editor
    "zoom" # meeting platform
    "numix-blue-gtk-theme-bin" # theme
    "numix-icon-theme-git" # theme
    "displaylink" # for tripple monitor
    "evdi-git" # for tripple monitor
)
onelineaur="${packagelistaur[*]}"
sudo aura -A --needed --no-confirm onelineaur

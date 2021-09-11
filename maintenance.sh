#!/usr/bin/env bash
#
# Script name: maintenance.sh
# Description: Script for keeping the system up to date
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

# Update
sudo pacman -Syu

# Yay Update
yay

#Delete Pacman Cache
sudo pacman -Scc

# Delete Yay Cache
yay -Scc

# Delete unwanted dependencies
yay -Yc

# Check Orphan packages
pacman -Qtdq

# Remove Orphan packages
sudo pacman -Rns $(pacman -Qtdq)

# Clean the Cache
rm -rf .cache/*

# Clean the journal
sudo journalctl --vacuum-time=2weeks

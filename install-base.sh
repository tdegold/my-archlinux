#!/usr/bin/env bash
#
# Script name: install-base.sh
# Description: Script for a basic installation of Arch Linux
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

######################
# Configuring locale #
######################
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" >> /etc/vconsole.conf

############
# Hostname #
############
echo "arch" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	arch" >> /etc/hosts

######################
# Root user password #
######################
echo root:password | chpasswd

#######################
# Installing packages #
#######################
declare -a packagelist=(
    "grub" # bootmanager
    "efibootmgr" # bootmanager
    "networkmanager" # networking
    "network-manager-applet" # networking
    "dialog" # networking
    "wpa_supplicant" # networking
    "inetutils" # networking
    "mtools" # filesystem stuff
    "dosfstools" # filesystem stuff
    "gvfs" # filesystem stuff
    "gvfs-afc" # filesystem stuff
    "gvfs-mtp" # filesystem stuff
    "gvfs-nfs" # filesystem stuff
    "gvfs-smb" # filesystem stuff
    "rsync" # mirrors
    "reflector" # mirrors
    "xdg-user-dirs" # xdg
    "xdg-utils" # xdg
    "bash-completion" # shell
    "tlp" # power management
    "docker" # docker
    "docker-compose" # docker
    "vim" # editor
)
oneline="${packagelist[*]}"
pacman -S --needed --no-confirm $oneline

######################
# Grub configuration #
######################
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

###################
# Enable services #
###################
systemctl enable NetworkManager
systemctl enable tlp
systemctl enable docker

################
# The Tim user #
################
useradd -m tim
echo tim:password | chpasswd
usermod -aG docker tim
echo "tim ALL=(ALL) ALL" >> /etc/sudoers.d/tim

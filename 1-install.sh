#!/usr/bin/env bash
#
# Script name: 1-install.sh
# Description: Second part of my Arch Linux installation script
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

# variables #
timezone="/Europe/Vienna"
lang="en_US.UTF-8"
locale="${lang} UTF-8"
keymap="de-latin1"
hostname="arch"
username="timde"

ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

hwclock --systohc

echo ${locale} >> /etc/locale.gen
locale-gen

echo "LANG=${lang}" >> /etc/locale.conf

echo "KEYMAP=${keymap}" >> /etc/vconsole.conf

echo ${hostname} >> /etc/hostname

echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1		 localhost" >> /etc/hosts
echo "127.0.1.1	 ${hostname}" >> /etc/hosts

echo "#####################"
echo "# Set root password #"
echo "#####################"
passwd

useradd -m ${username}
echo "##################################"
echo "# Set password for non-root user #"
echo "##################################"
passwd tim
usermod -aG wheel ${username}
EDITOR=vim visudo

pacman -S --needed --noconfirm < base_packages.txt

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable tlp
systemctl enable NetworkManager

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
username="tim"

ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

hwclock --systohc

echo "${locale}" >> /etc/locale.gen
locale-gen

echo "LANG=${lang}" >> /etc/locale.conf

echo "KEYMAP=${keymap}" >> /etc/vconsole.conf

echo "${hostname}" >> /etc/hostname

echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	${hostname}" >> /etc/hosts

echo "Set root password"
passwd

useradd -m ${username}
echo "Set password for user ${username}"
passwd tim
usermod -aG wheel ${username}
EDITOR=vim visudo

declare -a packages=(
    grub 
    efibootmgr 
    networkmanager 
    network-manager-applet 
    dialog 
    wpa_supplicant 
    mtools 
    dosfstools 
    avahi 
    xdg-user-dirs 
    xdg-utils 
    gvfs 
    gvfs-smb 
    nfs-utils 
    inetutils 
    dnsutils 
    bash-completion 
    rsync 
    reflector 
    acpi 
    acpi_call 
    terminus-font
)

for i in "${packages[@]}"
do
   pacman -S $i --needed --noconfirm
done

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

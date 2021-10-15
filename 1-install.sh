#!/usr/bin/env bash
#
# Script name: 1-install.sh
# Description: Second part of my Arch Linux installation script
# GitHub: https://github.com/tdegold/my-archlinux/
# Contributors: Tim Degold

# variables #
timezone=/Europe/Vienna
lang=en_US.UTF-8
locale=${lang}UTF-8
keymap=de-latin1
hostname=arch
root_password=password
username=tim
user_password=0406

ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

hwclock --systohc

echo ${locale} >> /etc/locale.gen
locale-gen

echo LANG=${lang} >> /etc/locale.conf

echo KEYMAP=${keymap} >> /etc/vconsole.conf

echo ${hostname} >> /etc/hostname

echo 127.0.0.1  localhost >> /etc/hosts
echo ::1		localhost >> /etc/hosts
echo 127.0.1.1	${hostname} >> /etc/hosts

echo root:${root_password} | chpasswd

useradd -m ${username}
echo '$username:$user_password' | chpasswd
usermod -aG wheel ${username}
EDITOR=vim visudo
